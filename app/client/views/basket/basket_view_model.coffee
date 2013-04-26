#= require ./basket_view

App = window.App
App.Views.Basket = {}

class App.Views.Basket.BasketViewModel
  globalData: App.GlobalData

  gridColumns: [
    {
      label: 'Artikel'
      width: 150
      type: 'ro'
    },
    {
      label: 'Antal'
      width: 50
      type: 'ed'
      align: 'right'
    },
    {
      label: 'Varumärke'
      width: 100
      type: 'ro'
    },
    {
      label: 'Tillverkare'
      width: 70
      type: 'ro'
    },
    {
      label: 'Produktgrupp'
      width: 120
      type: 'ro'
    },
    {
      label: 'Axet'
      width: 70
      type: 'ro'
    },
    {
      label: 'Citymarket Stenhaga'
      width: 70
      type: 'ro'
    },
    {
      label: 'Minimani'
      width: 70
      type: 'ro'
    },
    {
      label: 'Prisma'
      width: 70
      type: 'ro'
    }
  ]
  
  gridColumnHeaders: [
    '#text_filter'
    ''
    '#combo_filter'
    '#combo_filter'
    '#combo_filter'
    '#rspan'
    '#rspan'
    '#rspan'
    '#rspan'
  ]

  columnIds: [
    'name'
    'qty'
    'brand'
    'manufacturer'
    'productGroup'
    'prices.axet'
    'prices.citymarket'
    'prices.minimani'
    'prices.prisma'
  ]

  refresh: () ->
    $('#nonSpinnerContent').hide()
    App.Spinner.startSpinning('spinnerContent')

    $.ajax(
      type: 'GET'
      cache: false
      url: "/api/products"
      
      success: (result) =>
        items = eval result

        items = _.chain(items)
                    .select((item) =>
                      @globalData.basketItems[item.objectId]?
                    )
                    .map((item) =>
                      item.count = @globalData.basketItems[item.objectId]
                      item
                    )
                    .value()

        App.Spinner.stopSpinning('spinnerContent')
        @renderProductRows(items)
        $('#nonSpinnerContent').show()
      
      failure: (errMsg) =>
        $('#nonSpinnerContent').show()
    )

  renderProductRows: (items) ->
    @grid = new dhtmlXGridObject(
      parent: 'basketGrid'
      image_path: 'assets/dhtmlx/imgs/'
      skin: 'dhx_skyblue'
      columns: @gridColumns
      headers: [ @gridColumnHeaders ]
    )
    @grid.setColumnIds(@columnIds.join(','))
    @grid.attachEvent('onSelectStateChanged', (id) ->
      $('.deleteRowButton').removeAttr('disabled')
    )
    @grid.attachEvent('onAfterRowDeleted', (id, pid) ->
      $('.deleteRowButton').attr('disabled', 'true')
    )
    @grid.enableAutoWidth(true)
    @grid.enableAutoHeight(true)

    @loadData(items)

  loadData: (items) ->
    # The dhtmlxGrid requires the data to follow a certain form, so we map it to that here.
    data = {
      rows: _.map(items, (item) ->
        {
          id: item.objectId
          data: [
            "#{item.name} (#{item.qty} #{item.unitOfMeasure})"
            item.count          # The qty we are buying.
            item.brand
            item.manufacturer
            item.productGroup
            item.prices?.axet
            item.prices?.citymarket
            item.prices?.minimani
            item.prices?.prisma
          ]
        }
      )
    }

    @grid.parse(data, 'json')

  setupEventHandlers: () ->
    viewModel = @

    $('[data-command]').each(() ->
      obj = $(this)
      commandHandler = obj.attr('data-command')
      obj.click(() ->
        viewModel[commandHandler](obj)
        false
      )
    )

  deleteRow: ((obj) ->
    if confirm("Är det säkert att du vill ta bort '" + @grid.cells(@grid.getSelectedRowId(), 0).getValue() + "'?")
      @grid.deleteSelectedRows()

    @globalData.updateItemCount()
  )

class App.Views.Basket.BasketView
  templateName: 'views/basket/basket_view'

  didInsertElement: () ->
    @dataContext.refresh()
#= require ./basket_view
#= require ./basket_rows_view

App = window.App
App.Views.Basket = {}

class App.Views.Basket.BasketViewModel
  globalData: App.GlobalData
  items: []

  gridColumns: [
    {
      label: 'Artikel'
      width: 150
      type: 'ro'
    },
    # TODO: handle changes and propagate them back to the basket.
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
    App.Spinner.startSpinning('productRowsContainer')

    $.ajax(
      type: 'GET'
      cache: false
      url: "/api/products"
      
      success: (result) =>
        items = eval result

        @items = _.chain(items)
                    .select((item) =>
                      @globalData.basketItems[item.objectId]?
                    )
                    .map((item) =>
                      item.count = @globalData.basketItems[item.objectId]
                      item
                    )
                    .value()

        App.Spinner.stopSpinning('productRowsContainer')
        @renderProductRows()
        $('#productRowsContainer').show()
      
      failure: (errMsg) =>
        $('#productRowsContainer').show()
    )

  renderProductRows: () ->
    @setupEventHandlers()

    #@grid.attachEvent('onSelectStateChanged', (id) ->
    #  $('.deleteRowButton').removeAttr('disabled')
    #)
    #@grid.attachEvent('onAfterRowDeleted', (id, parentId) ->
    #  $('.deleteRowButton').attr('disabled', 'true')
    #)
    #@grid.attachEvent('onEnter', (id, cellIndex) =>
    #  @grid.selectCell(@grid.getRowIndex(id), 1, false, false, true)
    #)

    html = App.RenderTemplate('views/basket/basket_rows_view', this)
    $('#productRowsContainer').html(html).show()

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
    # TODO: delete from basket also.
    @grid.deleteSelectedRows()

    @globalData.updateItemCount()
  )

class App.Views.Basket.BasketView
  templateName: 'views/basket/basket_view'

  didInsertElement: () ->
    @dataContext.refresh()
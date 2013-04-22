#= require ./edit_products_view

App = window.App

App.Views.EditProducts = {}

class App.Views.EditProducts.EditProductsViewModel
  globalData: App.GlobalData

  isWaiting: false
  spinner: new Spinner
  grid: null

  unitOfMeasures: [
    'kg',
    'l',
    'm',
    'st'
  ]

  gridColumns: [
    {
      label: 'Artikel'
      width: 150
      type: 'edtxt'
    },
    {
      label: 'Vikt/volym'
      width: 70
      type: 'edtxt'
      align: 'right'
    },
    {
      label: '#cspan'
      width: 25
      type: 'ed'
    },
    {
      label: 'Varumärke'
      width: 100
      type: 'combo'
    },
    {
      label: 'Tillverkare'
      width: 70
      type: 'combo'
    },
    {
      label: 'Produktgrupp'
      width: 120
      type: 'edtxt'
    },
    {
      label: 'Axet'
      width: 70
      type: 'ed'
    },
    {
      label: 'Citymarket Stenhaga'
      width: 70
      type: 'ed'
    },
    {
      label: 'Minimani'
      width: 70
      type: 'ed'
    },
    {
      label: 'Prisma'
      width: 70
      type: 'ed'
    }
  ]
  
  gridColumnHeaders: [
    '#text_filter'
    ''
    '#cspan'
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
    'unitOfMeasure'
    'brand'
    'manufacturer'
    'productGroup'
    'prices.axet'
    'prices.citymarket'
    'prices.minimani'
    'prices.prisma'
  ]

  refresh: () ->
    App.Spinner.startSpinning('spinnerContent')

    $.ajax(
      type: 'GET'
      cache: false
      url: '/api/products'
      
      success: (result) =>
        items = eval result

        App.Spinner.stopSpinning('spinnerContent')
        @renderProductRows(items)
      
      failure: (errMsg) =>
    )

  renderProductRows: (items) ->
    @setupEventHandlers()

    @grid = new dhtmlXGridObject(
      parent: 'productsGrid'
      image_path: 'assets/dhtmlx/imgs/'
      skin: 'dhx_skyblue'
      columns: @gridColumns
      headers: [ @gridColumnHeaders ]
    )
    @grid.setColumnIds(@columnIds.join(','))
    @grid.attachEvent('onSelectStateChanged', (id) ->
      $('.deleteRowButton').removeAttr('disabled')
    )
    @grid.enableAutoHeight(true)

    processor = new dataProcessor('api/product')
    processor.setTransactionMode('POST')
    processor.enableDataNames(true)
    processor.init(@grid);

    @loadData(items)

  loadData: (items) ->
    # The dhtmlxGrid requires the data to follow a certain form, so we map it to that here.
    data = {
      rows: _.map(items, (item) ->
        {
          id: item.objectId
          data: [
            item.name
            item.qty
            item.unitOfMeasure
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

  addNewRow: () ->
    @grid.addRow(@grid.uid(), [])

  deleteRow: ((obj) ->
    if confirm("Är det säkert att du vill ta bort '" + @grid.cells(@grid.getSelectedRowId(), 0).getValue() + "'?")
      @grid.deleteSelectedRows()
  )

class App.Views.EditProducts.EditProductsView
  templateName: 'views/edit_products/edit_products_view'

  didInsertElement: () ->
    @dataContext.refresh()

#= require ./edit_products_view

App = window.App

App.Views.EditProducts = {}

class App.Views.EditProducts.EditProductsViewModel
  globalData: App.GlobalData

  isWaiting: false
  spinner: new Spinner
  items: []

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
      type: 'ed'
    },
    {
      label: 'Vikt/volym'
      width: 70
      type: 'ed'
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
      type: 'ed'
    },
    {
      label: 'Tillverkare'
      width: 70
      type: 'ed'
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
      label: 'Citymarket'
      width: 70
      type: 'ed'
    },
    {
      label: 'Lidl'
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
    'prices.lidl'
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
        items = _.sortBy(items, (i) ->
          "#{i.name}_#{i.brand}"
        )

        @items = items
        App.Spinner.stopSpinning('spinnerContent')
        @renderProductRows()
      
      failure: (errMsg) =>
    )

  renderProductRows: () ->
    #@setupEventHandlers()
    grid = new dhtmlXGridObject(
      parent: 'productsGrid'
      image_path: 'assets/dhtmlx/imgs/'
      skin: 'dhx_skyblue'
      columns: @gridColumns
      headers: [ @gridColumnHeaders ]
    )
    console.log @
    grid.setColumnIds(@columnIds.join(','))

    data = {
      rows: _.map(@items, (item) ->
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
            item.prices?.lidl
            item.prices?.minimani
            item.prices?.prisma
          ]
        }
      )
    }

    grid.parse(data, 'json')
    processor = new dataProcessor('api/product')
    processor.setTransactionMode('POST')
    processor.enableDataNames(true)
    processor.init(grid);

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
    #trObject = $(obj).parents('tr')
    #slug = trObject.attr('data-slug')
    #item = _.find(@items, (item) ->
    #  item.slug == slug
    #)

    #itemIndex = @items.indexOf(item)
    #@items.splice(itemIndex, 1)
    #trObject.remove()

    false
  )

  addNewRow: () ->
    @items.push(
      slug: new Date().getTime()
    )
    @productRowsView.sync()

  saveRows: ->
    $.ajax(
      type: 'POST'
      cache: false
      url: '/api/products'
      data: JSON.stringify(@get('items'))
      contentType: 'application/json; charset=utf-8'
      dataType: 'json'
      failure: (errMsg) =>
        alert('Ett fel uppstod när ändringarna skulle sparas: ' + errMsg)
        @set('isLoading', false)
      success: () =>
        alert('Ändringarna har sparats.')
    )

class App.Views.EditProducts.EditProductsView
  templateName: 'views/edit_products/edit_products_view'

  didInsertElement: () ->
    @dataContext.refresh()

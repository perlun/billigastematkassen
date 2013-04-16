#= require ./edit_products_view
#= require ./edit_products_rows_view

App = window.App

App.Views.EditProducts = {}

class App.Views.EditProducts.EditProductsViewModel
  isWaiting: false
  spinner: new Spinner
  items: []
  unitOfMeasures: [
    'kg',
    'l',
    'm',
    'st'
  ]
  globalData: App.GlobalData
  productRowsView: null

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
    # TODO: Possibly remove altogether (remove the files then also)
    #html = App.RenderTemplate('views/edit_products/edit_products_rows_view', this)
    #$('#productRowsContainer').html(html).show()
    #@productRowsView = rivets.bind($('#productRows'), @)

    #@setupEventHandlers()
    grid = new dhtmlXGridObject('productsGrid')
    grid.setImagePath 'assets/dhtmlx/imgs/'
    grid.setHeader([
        'Artikel',
        'Vikt/volym',
        'Enhet',
        'Varumärke',
        'Tillverkare',
        
        'Produktgrupp',
        'Axet',
        'Citymarket',
        'Lidl',
        'Minimani',
        'Prisma' 
      ].join(', '))
    grid.setInitWidths([
        150,
        70,
        50,
        100,
        70,

        120,
        70,
        70,
        70,
        70,
        70
      ].join(', '))
    grid.setColAlign 'left,right,left,left,left,left,left,left,left,left,left'
    grid.setColTypes 'ed,ed,ed,ed,ed,ed,ed,ed,ed,ed,ed'
    grid.attachHeader('#text_filter,#rspan,#rspan,#combo_filter,#combo_filter,#combo_filter,#rspan,#rspan,#rspan,#rspan,#rspan')

    grid.setSkin 'dhx_skyblue'

    grid.init()
    itemsArray = _.map(@items, (item) ->
      [
        item.name,
        item.qty,
        item.unitOfMeasure,
        item.brand,
        item.manufacturer,
        item.productGroup,
        item.prices?.axet,
        item.prices?.citymarket,
        item.prices?.lidl,
        item.prices?.minimani,
        item.prices?.prisma
      ]
    )
    grid.parse(itemsArray, 'jsarray')

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

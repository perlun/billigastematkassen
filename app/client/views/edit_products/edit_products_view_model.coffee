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
    html = App.RenderTemplate('views/edit_products/edit_products_rows_view', this)
    $('#productRowsContainer').html(html).show()
    rivets.bind($('#productRows'), @)

    #@setupEventHandlers()

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
    trObject = $(obj).parents('tr')
    slug = trObject.attr('data-slug')
    item = _.find(@items, (item) ->
      item.slug == slug
    )

    itemIndex = @items.indexOf(item)
    @items.splice(itemIndex, 1)
    trObject.remove()

    false
  )

  addNewRow: () ->
    @items.push(
      slug: new Date().getTime()
    )
    @renderProductRows()

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

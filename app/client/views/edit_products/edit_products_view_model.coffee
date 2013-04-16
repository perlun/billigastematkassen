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
    html = App.RenderTemplate('views/edit_products/edit_products_rows_view', this)
    $('#productRowsContainer').html(html).show()
    $('#productRowsTable').dataTable(
      bPaginate: false
      bSort: false
    )

    $('tfoot th').each((i) ->
      console.log "i:" + i
      this.innerHTML = createSelect('spam', 'egg', 'bacon') #oTable.fnGetColumnData(i));

      #$('select', this).change(function () {
      #    oTable.fnFilter($(this).val(), i);
      #})
    )
    #@productRowsView = rivets.bind($('#productRows'), @)

    @setupEventHandlers()

  createSelect: (data) ->
    result = '<select><option value=""></option>'
    result += "<option value='#{value}'>#{value}</option>" for value in data
    result + '</select>'

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
    row = []
    row[0] = '(namn)'
    row[x] = '' for x in [1..11]
    
    $('#productRowsTable').dataTable().fnAddData(row)

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

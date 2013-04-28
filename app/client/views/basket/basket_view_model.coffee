#= require ./basket_view
#= require ./basket_rows_view

App = window.App
App.Views.Basket = {}

class App.Views.Basket.BasketViewModel
  globalData: App.GlobalData
  items: []

  refresh: () ->
    $('#nonSpinnerContent').hide()
    App.Spinner.startSpinning('productRowsContainer')

    $.ajax(
      type: 'GET'
      cache: false
      url: "/api/products"
      
      success: (result) =>
        products = eval result

        @items = App.BasketService.mergeBasketItemsWithProducts(products)

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
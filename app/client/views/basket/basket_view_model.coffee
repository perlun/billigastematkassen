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

        @updateSummaries()
      
      failure: (errMsg) =>
        $('#productRowsContainer').show()
    )

  renderProductRows: () ->
    @setupEventHandlers()

    # TODO: implement delete functionality.
    #@grid.attachEvent('onSelectStateChanged', (id) ->
    #  $('.deleteRowButton').removeAttr('disabled')
    #)
    #@grid.attachEvent('onAfterRowDeleted', (id, parentId) ->
    #  $('.deleteRowButton').attr('disabled', 'true')
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

  updateSummaries: () ->
    prices = {}
    prices.axet = _.reduce(@items, ((memo, item) ->
        memo + (item.prices?.axet || 0) * item.count
      ), 0)
    prices.citymarket = _.reduce(@items, ((memo, item) ->
        memo + (item.prices?.citymarket || 0) * item.count
      ), 0)
    prices.minimani = _.reduce(@items, ((memo, item) ->
        memo + (item.prices?.minimani || 0) * item.count
      ), 0)
    prices.prisma = _.reduce(@items, ((memo, item) ->
        memo + (item.prices?.prisma || 0) * item.count
      ), 0)

    lowestPriceType = App.BasketService.getLowestPriceType(prices)
    console.log lowestPriceType

    $('#axetPricesSum')
        .text(prices.axet)
        .attr('class', if lowestPriceType == 'axet' then 'lowestPrice' else '')
    $('#citymarketPricesSum')
        .text(prices.citymarket)
        .attr('class', if lowestPriceType == 'citymarket' then 'lowestPrice' else '')
    $('#minimaniPricesSum')
        .text(prices.minimani)
        .attr('class', if lowestPriceType == 'minimani' then 'lowestPrice' else '')
    $('#prismaPricesSum')
        .text(prices.prisma)
        .attr('class', if lowestPriceType == 'prisma' then 'lowestPrice' else '')

  deleteRow: ((obj) ->
    # TODO: delete from basket also.
    @grid.deleteSelectedRows()

    @globalData.updateItemCount()
  )

class App.Views.Basket.BasketView
  templateName: 'views/basket/basket_view'

  didInsertElement: () ->
    @dataContext.refresh()
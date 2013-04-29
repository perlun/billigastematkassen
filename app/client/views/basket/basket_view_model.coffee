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
    html = App.RenderTemplate('views/basket/basket_rows_view', this)
    $('#productRowsContainer').html(html).show()

    # Must come after the DOM has been fully set up.
    @setupEventHandlers()

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

    viewModel = @
    $('[data-count]').each(() ->
      obj = $(this)
      obj.change(() ->
        count = parseInt(obj.val(), 10)
        return if isNaN(count)

        itemId = obj.parents('tr').attr('data-itemId')
        App.BasketService.updateItem(itemId, count)

        item = _.find(viewModel.items, (item) -> item.objectId == itemId)
        item.count = count
        viewModel.updateSummaries()
      )
    )

  updateSummaries: () ->
    if @items.length == 0
      $('#axetPricesSum').hide()
      $('#citymarketPricesSum').hide()
      $('#minimaniPricesSum').hide()
      $('#prismaPricesSum').hide()
      $('#noPricesSum').show()
      return

    prices = {}
    prices.axet = _.reduce(@items, ((memo, item) ->
        memo + (item.prices?.axet || 0) * item.count
      ), 0).toFixed(2)
    prices.citymarket = _.reduce(@items, ((memo, item) ->
        memo + (item.prices?.citymarket || 0) * item.count
      ), 0).toFixed(2)
    prices.minimani = _.reduce(@items, ((memo, item) ->
        memo + (item.prices?.minimani || 0) * item.count
      ), 0).toFixed(2)
    prices.prisma = _.reduce(@items, ((memo, item) ->
        memo + (item.prices?.prisma || 0) * item.count
      ), 0).toFixed(2)

    lowestPriceType = App.BasketService.getLowestPriceType(prices)

    $('#noPricesSum').hide()
    $('#axetPricesSum')
        .text(prices.axet)
        .attr('class', if lowestPriceType == 'axet' then 'price lowestPrice' else 'price')
    $('#citymarketPricesSum')
        .text(prices.citymarket)
        .attr('class', if lowestPriceType == 'citymarket' then 'price lowestPrice' else 'price')
    $('#minimaniPricesSum')
        .text(prices.minimani)
        .attr('class', if lowestPriceType == 'minimani' then 'price lowestPrice' else 'price')
    $('#prismaPricesSum')
        .text(prices.prisma)
        .attr('class', if lowestPriceType == 'prisma' then 'price lowestPrice' else 'price')

  deleteRow: ((obj) ->
    tableRow = obj.parents('tr')
    itemId = tableRow.attr('data-itemId')

    App.BasketService.deleteItem(itemId)
    tableRow.remove()

    @items = _.reject(@items, (item) ->
      item.objectId == itemId
    )
    @updateSummaries()

    false
  )

  clearBasket: () ->
    if confirm("Är det säkert att du vill tömma hela varukorgen?")
      App.BasketService.deleteAllItems()
      $('[data-itemId]').remove()

      @items = []
      @updateSummaries()

    false

class App.Views.Basket.BasketView
  templateName: 'views/basket/basket_view'

  didInsertElement: () ->
    @dataContext.refresh()
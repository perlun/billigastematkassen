App = window.App

App.BasketService = 
  basketItems: {}

  getBasket: () ->
    $.ajax(
      type: 'GET'
      cache: false
      url: '/api/basket'
      dataType: 'json'
    )

  getBasketCompleted: (items) ->
    @basketItems = items
    @updateItemCount()

  mergeBasketItemsWithProducts: (products) ->
    _.chain(products)
        .select((product) =>
          @basketItems[product.objectId]?
        )
        .map((item) =>
          item.count = @basketItems[item.objectId]
          item.lowestPriceType = @getLowestPriceType item.prices if item.prices?
          item
        )
        .value()

  getLowestPriceType: (obj) ->
    lowest = Number.MAX_VALUE
    lowestPriceType = ''

    for k,v of obj
      if v < lowest
        lowestPriceType = k
        lowest = v

    lowestPriceType

  addToBasket: (itemId) ->
    @basketItems[itemId] ||= 0
    @basketItems[itemId]++

    $.ajax(
      type: 'PUT'
      url: '/api/basket'
      contentType: 'application/json'
      data: JSON.stringify(@basketItems)

      error: (result) ->
        alert("Det gick inte att spara varukorgen. Felmeddelande: #{result.status} #{result.statusText}")
    )

    @updateItemCount()

  updateItemCount: () ->
    value = _.reduce(@basketItems, ((memo, num) ->
      memo + num
    ), 0)
    $('#itemCount').html(value)
    $('#itemCountContainer').show()

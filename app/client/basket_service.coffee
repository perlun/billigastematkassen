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

  mergeBasketItemsWithProducts: (products) ->
    _.chain(products)
        .select((product) =>
          @basketItems[product.objectId]?
        )
        .map((item) =>
          item.count = @basketItems[item.objectId]
          item
        )
        .value()

  addToBasket: (itemId) ->
    @basketItems[itemId] ||= 0
    @basketItems[itemId]++

    # TODO: Serialize and send to server.

    @updateItemCount()

  updateItemCount: () ->
    value = _.reduce(@basketItems, ((memo, num) ->
      memo + num
    ), 0)
    $('#itemCount').html(value)

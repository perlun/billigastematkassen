#= require views/basket/basket_view_model
#= require views/home/home_view_model
#= require views/main/main_view_model
#= require views/edit_products/edit_products_view_model
#= require views/list_products/list_products_view_model

App = window.App

class Routing
  constructor: () ->
    $(window).on('hashchange', @handleHashChange)

  run: () ->
    $().ready(() -> App.Spinner.startSpinning('placeholderContent'))

    $.when(@getProductGroups(), App.BasketService.getBasket())
      .then((productGroupsResult, basketResult) =>
        App.GlobalData.productGroups = productGroupsResult[0]

        App.activate(App.Views.Main.MainView, App.Views.Main.MainViewModel, '#bodyContent')
        App.BasketService.getBasketCompleted(basketResult[0])

        # TODO: Mixing up the data loading and the initial routing like this isn't so fanciful. We should probably raise some form
        # of event to let the router know that we are ready rather than doing it like this, so we can split out these two concerns
        # into different files.
        App.Spinner.stopSpinning('placeholderContent')
        @handleHashChange()
        $('#content').show()
      , (productGroupsResult, basketResult) ->
        console.error 'Error fetching product groups' if productGroupsResult.constructor == String
        console.error 'Error fetching basket' if basketResult.constructor  == String

        App.Spinner.stopSpinning('placeholderContent')
        $('#placeholderContent')
          .html(
            '<div class="alert alert-error">' +
            '<button type="button" class="close" data-dismiss="alert">&times;</button>' +
            '<h2>Fel</h2>' +
            'Applikationen kunde inte startas.</div>'
          )
          .show()
      )

  # MVVM/history micro-"framework"...
  handleHashChange: () ->
    if location.hash.indexOf('#/produkter/') != -1
      match = productGroup = /#\/produkter\/(.*)\/(.*)/.exec location.hash

      if match
        productGroup = match[1]
        productSubGroup = match[2]
      else
        match  = /#\/produkter\/(.*)/.exec location.hash
        productGroup = match[1]

      App.activate(App.Views.ListProducts.ListProductsView, App.Views.ListProducts.ListProductsViewModel, null, productGroup, productSubGroup)
    else if location.hash == '#/redigera/produkter'
      App.activate(App.Views.EditProducts.EditProductsView, App.Views.EditProducts.EditProductsViewModel, null, 'products')
    else if location.hash == '#/redigera/priser'
      App.activate(App.Views.EditProducts.EditProductsView, App.Views.EditProducts.EditProductsViewModel, null, 'prices')
    else if location.hash == '#/varukorg'
      App.activate(App.Views.Basket.BasketView, App.Views.Basket.BasketViewModel)
    else if location.hash == '#/start'
      App.activate(App.Views.Home.HomeView, null)
    else
      location.hash = '#/start'

  getProductGroups: () ->
    $.ajax(
      type: 'GET'
      cache: false
      url: '/api/productGroups'
      dataType: 'json'
    )

new Routing().run()

#= require views/main/main_view_model
#= require views/basket/basket_view_model
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
        App.BasketService.getBasketCompleted(basketResult[0])

        @mainViewModel = new App.Views.Main.MainViewModel()
        mainView = new App.Views.Main.MainView()
        mainView.dataContext = @mainViewModel
        App.Activate(mainView, @mainViewModel, 'body')

        # TODO: Mixing up the data loading and the initial routing like this isn't so fanciful. We should probably raise some form
        # of event to let the router know that we are ready rather than doing it like this, so we can split out these two concerns
        # into different files.
        App.Spinner.stopSpinning('content')
        @handleHashChange()
        $('#content').show()
      , (productGroupsResult, basketResult) ->
        console.error "Error fetching product groups" if productGroupsResult.constructor == String
        console.error "Error fetching basket" if basketResult.constructor  == String

        App.Spinner.stopSpinning('content')
        $('#content')
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
      viewModel = new App.Views.ListProducts.ListProductsViewModel
      view = new App.Views.ListProducts.ListProductsView
      view.dataContext = viewModel

      App.Activate(view, viewModel)
    else if location.hash == '#/redigera'
      viewModel = new App.Views.EditProducts.EditProductsViewModel
      view = new App.Views.EditProducts.EditProductsView
      view.dataContext = viewModel

      App.Activate(view, viewModel)
    else if location.hash == '#/varukorg'
      viewModel = new App.Views.Basket.BasketViewModel
      view = new App.Views.Basket.BasketView    
      view.dataContext = viewModel

      App.Activate(view, viewModel)
    else
      location.hash = '#/produkter/' + _.first(App.GlobalData.productGroups).slug

  getProductGroups: () ->
    $.ajax(
      type: 'GET'
      cache: false
      url: '/api/productGroups'
      dataType: 'json'
    )

new Routing().run()

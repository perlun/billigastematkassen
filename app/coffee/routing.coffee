#= require views/list_products/list_products_view_model
#= require views/edit_prices/edit_prices_view_model

@App.Router = Ember.Router.extend({
  root: Ember.Route.extend({
    index: Ember.Route.extend({
      route: '/'
      connectOutlets: (router, context) ->
        ctrl = router.get('applicationController')

        ctrl.disconnectOutlet('content')

        ctrl.connectOutlet({
          viewClass: window.App.Views.ListProducts.ListProductsView
          outletName: 'content'
        })
    })

    admin: Ember.Route.extend({
      route: '/redigera'
      connectOutlets: (router, context) ->
        ctrl = router.get('applicationController')

        ctrl.disconnectOutlet('content')

        ctrl.connectOutlet({
          viewClass: window.App.Views.EditPrices.EditPricesView
          outletName: 'content'
        })
    })
  })
})

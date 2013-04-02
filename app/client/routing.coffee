#= require views/main/main_view_model
#= require views/list_products/list_products_view_model
#= require views/edit_prices/edit_prices_view_model

Ember = window.Ember
Handlebars = window.Handlebars

App = window.App

#App.Router.map(() ->
#  @resource('edit_prices')
#)

App.IndexView = App.Views.ListProducts.ListProductsView

App.IndexRoute = Ember.Route.extend(
#  renderTemplate: () ->
#    @render('views/list_products/list_products_view')
)
  
#
#        ctrl.connectOutlet({
#          viewClass: window.App.Views.ListProducts.ListProductsView
#          outletName: 'content'
#        })

# TODO: remove
gurka = Ember.Router.extend({
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

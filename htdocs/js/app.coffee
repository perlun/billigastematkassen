App = Ember.Application.create()

App.Views = {}
App.Views.Prices = {}

App.Views.Prices.PricesView = Ember.View.extend({
  templateName: 'prices'
})

App.Router = Ember.Router.extend({
  root: Ember.Route.extend({
    index: Ember.Route.extend({
      route: '/'
      connectOutlets: (router, context) ->
        ctrl = router.get('applicationController')

        ctrl.connectOutlet({
          viewClass: App.Views.Prices.PricesView
          outletName: 'prices'
        })
    })
  })
})

App.ApplicationController = Ember.Controller.extend()
App.initialize()

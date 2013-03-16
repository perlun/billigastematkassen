App = Ember.Application.create()

App.Views = {}
App.Views.Prices = {}

#
# Viewmodels and views.
#
App.Views.Prices.PricesViewModel = Ember.Controller.extend({
  items: []

  init: () ->
    $.ajax({
      type: 'GET'
      cache: false
      url: '/api/prices'
      success: (result) =>
        @set('items', eval result)
    })
})

App.Views.Prices.PricesView = Ember.View.extend({
  templateName: 'prices'
  init: () ->
    this._super()

    controller = App.Views.Prices.PricesViewModel.create()
    @set('_context', controller)
    @set('controller', controller)
})

#
# Routing
#
App.Router = Ember.Router.extend({
  root: Ember.Route.extend({
    index: Ember.Route.extend({
      route: '/'
      connectOutlets: (router, context) ->
        ctrl = router.get('applicationController')

        ctrl.disconnectOutlet('content')

        ctrl.connectOutlet({
          viewClass: App.Views.Prices.PricesView
          outletName: 'content'
        })
    })

    admin: Ember.Route.extend({
      route: '/redigera'
      connectOutlets: (router, context) ->
        ctrl = router.get('applicationController')

        ctrl.disconnectOutlet('content')

        # TODO.
    })
  })
})

App.ApplicationController = Ember.Controller.extend()
App.initialize()

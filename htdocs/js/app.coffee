App = Ember.Application.create()

App.Views = {}
App.Views.Prices = {}

#
# Controls
#
App.Controls = {}
App.Controls.MoneyTextField = Ember.TextField.extend({
  type: 'number'
  attributeBindings: [ 'step', 'style' ]
  step: 0.01
  size: 5
  style: 'width: 60px; padding: 0px 6px;'
})

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

App.Views.Prices.EditPricesViewModel = Ember.Controller.extend({
  items: []

  init: () ->
    $.ajax({
      type: 'GET'
      cache: false
      url: '/api/prices'
      success: (result) =>
        @set('items', eval result)
    })

  addNewRow: () ->
    @items.pushObject({})

  removeRow: (row) ->
    @items.removeObject(row.context)
})

App.Views.Prices.EditPricesView = Ember.View.extend({
  templateName: 'edit_prices'
  init: () ->
    this._super()

    controller = App.Views.Prices.EditPricesViewModel.create()
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

        ctrl.connectOutlet({
          viewClass: App.Views.Prices.EditPricesView
          outletName: 'content'
        })
    })
  })
})

App.ApplicationController = Ember.Controller.extend()
App.initialize()

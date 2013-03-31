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

App.Controls.AmountTextField = Ember.TextField.extend({
  type: 'number'
  attributeBindings: [ 'step', 'style' ]
  step: 0.001
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
        items = eval result
        @set('items', items)
    })
})

App.Views.Prices.PricesView = Ember.View.extend({
  templateName: 'prices'
  init: () ->
    @_super()

    controller = App.Views.Prices.PricesViewModel.create()
    @set('_context', controller)
    @set('controller', controller)
})

#
# Edit Prices
#
App.Views.Prices.EditPricesViewModel = Ember.Controller.extend({
  items: []
  unitOfMeasures: [
    'kg',
    'l'
  ]
  productGroups: [
    'Frukt och grönt',
    'Kött & chark',
    'Mejeri & ost',
    'Bageri',
    'Dryck',
    'Glass, godis och snacks',
    'Hem & hygien',
    'Skafferi',
    'Halvfabrikat & färdigmat'
  ]

  init: () ->
    $.ajax({
      type: 'GET'
      cache: false
      url: '/api/prices'
      success: (result) =>
        items = eval result
        items = _.sortBy(items, (i) ->
          "#{i.name}_#{i.brand}"
        )

        @set('items', items)
    })

  addNewRow: () ->
    @items.pushObject({})

  removeRow: (row) ->
    @items.removeObject(row.context)

  saveRows: ->
    $.ajax({
      type: 'POST'
      cache: false
      url: '/api/prices'
      data: JSON.stringify(@get('items'))
      contentType: 'application/json; charset=utf-8'
      dataType: 'json'
      failure: (errMsg) ->
        alert('Ett fel uppstod när priserna skulle sparas: ' + errMsg)
      success: () ->
        alert('Ändringarna har sparats.')
    })
})

App.Views.Prices.EditPricesView = Ember.View.extend({
  templateName: 'edit_prices'
  init: () ->
    @_super()

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

App.ApplicationController = Ember.Controller.extend({
  pricesLinkClass: false
  editLinkClass: false

  init: () ->
    window.addEventListener("hashchange", (event) =>
      @updateActiveClasses event.newURL
    false)

    # Must call for initial URL also.
    @updateActiveClasses window.location

  updateActiveClasses: (url) ->
    parsedUrl = $.url(url)

    fragment = parsedUrl.attr('fragment')
    @set('pricesLinkClass', (if fragment == '' then 'active' else ''))
    @set('editLinkClass', (if fragment == '/redigera' then 'active' else ''))
})

App.initialize()

@App.Views.ListProducts = {}

@App.Views.ListProducts.ListProductsViewModel = Ember.Controller.extend({
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

@App.Views.ListProducts.ListProductsView = Ember.View.extend({
  templateName: 'prices'
  init: () ->
    @_super()

    controller = window.App.Views.ListProducts.ListProductsViewModel.create()
    @set('_context', controller)
    @set('controller', controller)
})

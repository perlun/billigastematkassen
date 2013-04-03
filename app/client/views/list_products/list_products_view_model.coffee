#= require views/list_products/list_products_view

App = window.App

App.Views.ListProducts = {}

App.Views.ListProducts.ListProductsViewModel = Ember.Controller.extend(
  items: []

  init: () ->
    $.ajax(
      type: 'GET'
      cache: false
      url: '/api/prices'
      success: (result) =>
        items = eval result
        @set('items', items)
    )
)

App.Views.ListProducts.ListProductsView = Ember.View.extend(
  templateName: 'views/list_products/list_products_view'
)

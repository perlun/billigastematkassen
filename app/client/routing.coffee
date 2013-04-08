#= require views/main/main_view_model
#= require views/list_products/list_products_view_model
#= require views/edit_prices/edit_prices_view_model
#= require views/product_details/product_details_view_model

Ember = window.Ember
Handlebars = window.Handlebars
App = window.App

# Ember doesn't seem to handle views and controllers in sub-namespaces, so we work around this by setting some aliases.
App.EditPricesView = App.Views.EditPrices.EditPricesView
App.EditPricesController = App.Views.EditPrices.EditPricesViewModel
App.ProductsView = App.Views.ListProducts.ListProductsView
App.ProductsController = App.Views.ListProducts.ListProductsViewModel
App.ProductsDetailsView = App.Views.ProductDetails.ProductDetailsView
App.ProductsDetailsController = App.Views.ProductDetails.ProductDetailsViewModel

App.Router.map(() ->
  @route('edit_prices', path: '/redigera')
  @resource('products', { path: '/produkter' }, () ->
    @route('details', { path: '/:product_slug' })
  )
)

App.IndexRoute = Ember.Route.extend(
  redirect: () ->
    @transitionTo('products')
)

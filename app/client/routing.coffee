#= require views/main/main_view_model
#= require views/list_products/list_products_view_model
#= require views/edit_prices/edit_prices_view_model

Ember = window.Ember
Handlebars = window.Handlebars
App = window.App

# Ember doesn't seem to handle views and controllers in sub-namespaces, so we work around this by setting some aliases.
App.IndexView = App.Views.ListProducts.ListProductsView
App.IndexController = App.Views.ListProducts.ListProductsViewModel
App.EditPricesView = App.Views.EditPrices.EditPricesView
App.EditPricesController = App.Views.EditPrices.EditPricesViewModel

App.Router.map(() ->
  @route('EditPrices', path: '/redigera')
)

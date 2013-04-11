#= require views/main/main_view_model
#= require views/list_products/list_products_view_model
# require views/edit_prices/edit_prices_view_model
# require views/product_details/product_details_view_model

App = window.App

$('body').append(_.template(App.Templates[App.MainView.templateName], {}, { variable: 'ViewModel' }))

handleHashChange = () ->
  if location.hash == '#/produkter'
    view = new App.Views.ListProducts.ListProductsView
    viewModel = new App.Views.ListProducts.ListProductsViewModel
    $('#content').html(_.template(App.Templates[view.templateName], viewModel, { variable: 'ViewModel' }))
    console.log 'ListProducts'
  else if location.hash == '#/redigera'
    # TODO: Not yet implemented.
    $('#content').html('')
    console.log 'EditProducts'
  else
    location.hash = '#/produkter'

window.onhashchange = handleHashChange
handleHashChange()
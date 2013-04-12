#= require views/main/main_view_model
#= require views/list_products/list_products_view_model
# require views/edit_prices/edit_prices_view_model
# require views/product_details/product_details_view_model

App = window.App

$('body').append(_.template(App.Templates[App.MainView.templateName], {}, { variable: 'dataContext' }))

handleHashChange = () ->
  if location.hash == '#/produkter'
    viewModel = new App.Views.ListProducts.ListProductsViewModel
    view = new App.Views.ListProducts.ListProductsView
    view.dataContext = viewModel
    view.willInsertElement()
    $('#content').html(App.RenderTemplate(view.templateName, viewModel))
    view.didInsertElement()
    console.log 'ListProducts'
  else if location.hash == '#/redigera'
    # TODO: Not yet implemented.
    $('#content').html('')
    console.log 'EditProducts'
  else
    location.hash = '#/produkter'

window.onhashchange = handleHashChange
handleHashChange()

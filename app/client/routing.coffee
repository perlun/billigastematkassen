#= require views/main/main_view_model
#= require views/list_products/list_products_view_model
#= require views/edit_products/edit_products_view_model
#
# TODO: not yet working
# require views/product_details/product_details_view_model

App = window.App

$('body').append(_.template(App.Templates[App.MainView.templateName], {}, { variable: 'dataContext' }))

# MVVM micro-"framework"...
handleHashChange = () ->
  if location.hash == '#/produkter'
    viewModel = new App.Views.ListProducts.ListProductsViewModel
    view = new App.Views.ListProducts.ListProductsView
    view.dataContext = viewModel

    App.Activate(view, viewModel)
  else if location.hash == '#/redigera'
    viewModel = new App.Views.EditProducts.EditProductsViewModel
    view = new App.Views.EditProducts.EditProductsView
    view.dataContext = viewModel

    App.Activate(view, viewModel)
  else
    location.hash = '#/produkter'

window.onhashchange = handleHashChange

App.Spinner.startSpinning('content')

$.ajax(
  type: 'GET'
  cache: false
  url: '/api/productGroups'

  success: (result) ->
    App.GlobalData.productGroups = eval result

    App.Spinner.stopSpinning('content')
    $('#content').show()

    handleHashChange()
).fail(() ->
  App.Spinner.stopSpinning('content')
  $('#content')
      .html(
        '<div class="alert alert-error">' +
        '<button type="button" class="close" data-dismiss="alert">&times;</button>' +
        '<h2>Fel</h2>' +
        'Applikationen kunde inte startas.</div>'
      )
      .show()
)

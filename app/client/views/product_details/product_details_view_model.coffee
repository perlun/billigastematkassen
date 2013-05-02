#= require views/product_details/product_details_view

App = window.App
App.Views.ProductDetails = {}

class App.Views.ProductDetails.ProductDetailsViewModel
  view: null
  product: null

  showProductDetails: (product, templateName) ->
    @product = product
    elementName = '#inline'

    $.colorbox(
      open: true
      href: elementName
      html: App.RenderTemplate(templateName, @)
    )
    
    '#cboxLoadedContent'

class App.Views.ProductDetails.ProductDetailsView
  templateName: 'views/product_details/product_details_view'

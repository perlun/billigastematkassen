#= require views/product_details/product_details_view

App = window.App
App.Views.ProductDetails = {}

App.Views.ProductDetails.ProductDetailsViewModel = Ember.Controller.extend(
)

App.Views.ProductDetails.ProductDetailsView = Ember.View.extend(
  templateName: 'views/product_details/product_details_view'

  didInsertElement: () ->
    @$().colorbox(
      inline: true
      open: true
      href: '#inline'
      onLoad: () ->
        console.log 'onLoad'
        #$('#cboxLoadedContent').replaceWith('Loaded content')
        #$('#cboxContent').append('gurkan gurre')
        #$('#cboxLoadingGraphic').remove()
      onCleanup: () =>
        # A bit of a hack; could use the 'close' option in colorbox instead with a Handlebars link or something...
        @get('controller').get('target').transitionTo('products')
    )

  willDestroyElement: () ->
    $('#myModal').colorbox.close()
)

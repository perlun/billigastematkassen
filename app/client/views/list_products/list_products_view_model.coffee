#= require views/list_products/list_products_view

App = window.App

App.Views.ListProducts = {}

App.Views.ListProducts.ListProductsViewModel = Ember.Controller.extend(
  allItems: []
  filteredItems: []
  globalData: App.GlobalData

  refresh: () ->
    $.ajax(
      type: 'GET'
      cache: false
      url: '/api/prices'
      success: (result) =>
        items = eval result

        _.each(items, (i) ->
          i.detailsAnchor = "#/produkter/#{i.slug}"
        )

        @set('allItems', items)
        @set('filteredItems', items)    # No filter by default.
    )

  showProductGroup: (tabSlug) ->
    groupDescription = _.find(@globalData.productGroups, (g) ->
      g.tabSlug == tabSlug
    )?.description

    unless groupDescription?
      @set('filteredItems', @allItems)
    else
      @set('filteredItems',
        _.select(@allItems, (i) ->
          i.productGroup == groupDescription
        )
      )
)

App.Views.ListProducts.ListProductsView = Ember.View.extend(
  templateName: 'views/list_products/list_products_view'

  didInsertElement: () ->
    $('a[data-toggle="tab"]').on('show', (e) =>
      anchor = $.url(e.target.href).attr('anchor')
      @controller.showProductGroup('#' + anchor)
    )

    @controller.refresh()
)

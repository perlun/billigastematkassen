#= require views/list_products/list_products_view

App = window.App

App.Views.ListProducts = {}

class App.Views.ListProducts.ListProductsViewModel
  allItems: []
  filteredItems: []
  globalData: App.GlobalData

  refresh: () ->
    $.ajax(
      type: 'GET'
      cache: false
      url: '/api/products'
      success: (result) =>
        items = eval result

        _.each(items, (i) ->
          i.detailsAnchor = "#/produkter/#{i.slug}"
        )

        @set('allItems', items)
        @showOnlyProductsInGroup _.first(@globalData.productGroups).description
    )

  showProductGroup: (tabSlug) ->
    groupDescription = _.find(@globalData.productGroups, (g) ->
      g.tabSlug == tabSlug
    )?.description

    @showOnlyProductsInGroup groupDescription

  showOnlyProductsInGroup: (groupDescription) ->
    @set('filteredItems',
      _.select(@allItems, (i) ->
        i.productGroup == groupDescription
      )
    )

class App.Views.ListProducts.ListProductsView
  templateName: 'views/list_products/list_products_view'

  didInsertElement: () ->
    $('a[data-toggle="tab"]').on('show', (e) =>
      anchor = $.url(e.target.href).attr('anchor')
      @controller.showProductGroup('#' + anchor)
    )

    # Slightly ugly, but... :)
    $('a[data-toggle="tab"]').first().click()

    @controller.refresh()

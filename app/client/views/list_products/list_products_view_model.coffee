#= require views/list_products/list_products_view
#= require views/list_products/list_products_rows_view

App = window.App
Spinner = window.Spinner

App.Views.ListProducts = {}

class App.Views.ListProducts.ListProductsViewModel
  allItems: []
  filteredItems: []
  globalData: App.GlobalData
  spinner: null

  refresh: () ->
    App.Spinner.startSpinning('productRowsContainer')

    $.ajax(
      type: 'GET'
      cache: false
      url: '/api/products'
      success: (result) =>
        items = eval result

        _.each(items, (i) ->
          i.detailsAnchor = "#/produkter/#{i.slug}"
        )

        @allItems = items
        @showOnlyProductsInGroup _.first(@globalData.productGroups).description

        App.Spinner.stopSpinning('productRowsContainer')
        @renderProductRows()
    )

  renderProductRows: () ->
    html = App.RenderTemplate('views/list_products/list_products_rows_view', this)
    $('#productRowsContainer').html(html).show()

  showProductGroup: (tabSlug) ->
    groupDescription = _.find(@globalData.productGroups, (g) ->
      g.tabSlug == tabSlug
    )?.description

    @showOnlyProductsInGroup groupDescription
    @renderProductRows()

  showOnlyProductsInGroup: (groupDescription) ->
    @filteredItems = _.select(@allItems, (i) ->
      i.productGroup == groupDescription
    )

class App.Views.ListProducts.ListProductsView
  templateName: 'views/list_products/list_products_view'

  didInsertElement: () ->
    @dataContext.refresh()

    $('a[data-toggle="tab"]').on('show', (e) =>
      anchor = $.url(e.target.href).attr('anchor')
      @dataContext.showProductGroup('#' + anchor)
    )

    # Slightly ugly, but... :)
    $('a[data-toggle="tab"]').first().click()

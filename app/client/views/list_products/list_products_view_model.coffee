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
    @startSpinning('productRowsContainer')

#    target = document.getElementById('#container')
#    @spinner.spin(target)

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

        @stopSpinning('productRowsContainer')
        @renderProductRows()
    )

  startSpinning: (elementName) ->
    $('#' + elementName).spin(
      lines: 13       # The number of lines to draw
      length: 20      # The length of each line
      width: 10       # The line thickness
      radius: 30      # The radius of the inner circle
      corners: 1      # Corner roundness (0..1)
      rotate: 0       # The rotation offset
      color: '#000'   # #rgb or #rrggbb
      speed: 1        # Rounds per second
      trail: 60       # Afterglow percentage
      shadow: false   # Whether to render a shadow
      hwaccel: false  # Whether to use hardware acceleration
    )

  stopSpinning: (elementName) ->
    $('#' + elementName).spin(false)

  renderProductRows: () ->
    html = App.RenderTemplate('views/list_products/list_products_rows_view', this)
    $('#productRowsContainer').html(html)

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

  willInsertElement: () ->

  didInsertElement: () ->
    @dataContext.refresh()

    $('a[data-toggle="tab"]').on('show', (e) =>
      anchor = $.url(e.target.href).attr('anchor')
      @dataContext.showProductGroup('#' + anchor)
    )

    # Slightly ugly, but... :)
    $('a[data-toggle="tab"]').first().click()

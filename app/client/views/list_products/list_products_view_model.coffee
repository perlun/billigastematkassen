#= require views/list_products/list_products_view
#= require views/list_products/list_products_rows_view
#= require views/product_details/product_details_view_model

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
        @showOnlyProductsInGroup _.first(@globalData.productGroups).name

        App.Spinner.stopSpinning('productRowsContainer')
        @renderProductRows()
    )

  showProductGroup: (groupSlug) ->
    groupName = _.find(@globalData.productGroups, (g) ->
      g.slug == groupSlug
    )?.name

    @showOnlyProductsInGroup groupName
    @renderProductRows()

  showOnlyProductsInGroup: (groupName) ->
    @filteredItems = _.select(@allItems, (i) ->
      i.productGroup == groupName
    )

  renderProductRows: () ->
    html = App.RenderTemplate('views/list_products/list_products_rows_view', this)
    $('#productRowsContainer').html(html).show()
    @setupEventHandlers()

  setupEventHandlers: (parent) ->
    viewModel = @

    (parent || $('body')).find('[data-command]').each(() ->
      obj = $(this)
      commandHandler = obj.attr('data-command')
      obj.click(() ->
        viewModel[commandHandler](obj)
        false
      )
    )

  addToBasket: (obj) ->
    itemId = obj.attr('data-itemId')
    App.BasketService.addToBasket(itemId)
    false

  showProductDetails: (obj) ->
    viewModel = new App.Views.ProductDetails.ProductDetailsViewModel()
    view = new App.Views.ProductDetails.ProductDetailsView()

    itemId = obj.attr('data-itemId')
    item = _.find(@allItems, (item) -> item.objectId == itemId)
    elementName = viewModel.showProductDetails(item, view.templateName)

    @setupEventHandlers($(elementName))

    false

class App.Views.ListProducts.ListProductsView
  templateName: 'views/list_products/list_products_view'

  didInsertElement: () ->
    @dataContext.refresh()

    $('a[data-toggle="tab"]').on('show', (e) =>
      anchor = $.url(e.target.href).attr('anchor')
      @dataContext.showProductGroup(anchor)
    )

    # Slightly ugly, but... :)
    $('a[data-toggle="tab"]').first().click()

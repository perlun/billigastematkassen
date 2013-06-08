#= require views/list_products/list_products_view
#= require views/list_products/list_products_rows_view
#= require views/list_products/product_sub_groups_view
#= require views/product_details/product_details_view_model

App = window.App
Spinner = window.Spinner

App.Views.ListProducts = {}

class App.Views.ListProducts.ListProductsViewModel
  allItems: null
  filteredItems: []
  globalData: App.GlobalData
  productGroup: null
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
        App.Spinner.stopSpinning('productRowsContainer')

        @showProductGroup()
    )

  setParameters: (productGroupSlug, productSubGroup) ->
    @productGroup = _.find(@globalData.productGroups, (g) ->
      g.slug == productGroupSlug
    )

    @productSubGroup = productSubGroup

    # We may or may not have data at this point.
    if @allItems
      @showProductGroup()

  showProductGroup: () ->
    return unless @productGroup?

    @filteredItems = _.select(@allItems, (i) =>
      i.productGroup == @productGroup.name
    )

    if @productSubGroup
      @filteredItems = _.select(@filteredItems, (i) => App.slugify(i.productSubGroup) == @productSubGroup)

    $('#extraNavigationPlaceholder')
      .html(App.renderTemplate('views/list_products/product_sub_groups_view', @))
      .show()
    @renderProductRows()

  renderProductRows: () ->
    html = App.renderTemplate('views/list_products/list_products_rows_view', this)
    $('#productRowsContainer').html(html).show()
    App.setupCommandHandlers(@)

  addToBasket: (param) ->
    # The parameter can be either a DOM element or an itemId, so we need to perform some 'duck-typing'-style detection to
    # support both cases.
    if param.attr?
      itemId = param.attr('data-itemId')
    else
      itemId = param

    App.BasketService.addToBasket(itemId)
    false

  addToBasketAndCloseOverlay: (element) ->
    @addToBasket(element)
    @productDetailsViewModel.closeOverlay()

  addAllToBasket: () ->
    _.each(@filteredItems, (item) =>
      @addToBasket(item.objectId)
    )

  showProductDetails: (obj) ->
    @productDetailsViewModel = new App.Views.ProductDetails.ProductDetailsViewModel()
    view = new App.Views.ProductDetails.ProductDetailsView()

    itemId = obj.attr('data-itemId')
    item = _.find(@allItems, (item) -> item.objectId == itemId)
    elementName = @productDetailsViewModel.showProductDetails(item, view.templateName)

    App.setupCommandHandlers(@, $(elementName))

    false

class App.Views.ListProducts.ListProductsView
  templateName: 'views/list_products/list_products_view'

  didInsertElement: () ->
    @dataContext.refresh()

  didRemoveElement: () ->
    $('#extraNavigationPlaceholder').hide()

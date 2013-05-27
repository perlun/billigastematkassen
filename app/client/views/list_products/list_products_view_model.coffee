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

  addToBasketAndCloseOverlay: (obj) ->
    @addToBasket(obj)
    @productDetailsViewModel.closeOverlay()

  showProductDetails: (obj) ->
    @productDetailsViewModel = new App.Views.ProductDetails.ProductDetailsViewModel()
    view = new App.Views.ProductDetails.ProductDetailsView()

    itemId = obj.attr('data-itemId')
    item = _.find(@allItems, (item) -> item.objectId == itemId)
    elementName = @productDetailsViewModel.showProductDetails(item, view.templateName)

    @setupEventHandlers($(elementName))

    false

class App.Views.ListProducts.ListProductsView
  templateName: 'views/list_products/list_products_view'

  didInsertElement: () ->
    @dataContext.refresh()

  didRemoveElement: () ->
    $('#extraNavigationPlaceholder').hide()

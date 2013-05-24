#= require ./edit_products_view
#= require ./edit_products_rows_view

App = window.App
App.Views.EditProducts = {}

class App.Views.EditProducts.EditProductsViewModel
  globalData: App.GlobalData

  isWaiting: false
  spinner: new Spinner
  allItems: null
  items: null

  unitOfMeasures: [
    'kg',
    'l',
    'm',
    'st'
  ]
  
  refresh: () ->
    @setupEventHandlers()

  showProductGroup: (groupSlug) ->
    @activeProductGroup = _.find(@globalData.productGroups, (g) -> g.slug == groupSlug)

    if @allItems
      @filterItems(groupSlug)
      @renderProductRows()
      return

    $('#nonSpinnerContent').hide()
    App.Spinner.startSpinning('spinnerContent')

    $.ajax(
      type: 'GET'
      cache: false
      url: '/api/products'
      
      success: (result) =>
        @allItems = eval result
        @filterItems(groupSlug)

        App.Spinner.stopSpinning('spinnerContent')
        @renderProductRows()
        $('#nonSpinnerContent').show()
      
      error: (jqXHR, textStatus, errorThrown) =>
        App.Spinner.stopSpinning('spinnerContent')

        $('#nonSpinnerContent')
          .html(
            '<div class="alert alert-error">' +
            '<button type="button" class="close" data-dismiss="alert">&times;</button>' +
            '<h2>Fel</h2>' +
            "Produktlistan kunde inte hämtas. Felmeddelande: #{errorThrown}.</div>"
          )
          .show()
    )

  filterItems: (groupSlug) ->
    @items = _.select(@allItems, (item) =>
      @slugify(item.productGroup) == groupSlug
    )

  renderProductRows: () ->
    html = App.renderTemplate('views/edit_products/edit_products_rows_view', this)
    $('#productRowsContainer').html(html).show()

    @setupRowsEventHandlers()

  setupEventHandlers: () ->
    viewModel = @

    $('[data-command]').each(() ->
      obj = $(this)
      commandHandler = obj.attr('data-command')
      obj.click(() ->
        viewModel[commandHandler](obj)
        false
      )
    )

  setupRowsEventHandlers: () ->
    viewModel = @

    $('[data-row-command]').each(() ->
      obj = $(this)
      commandHandler = obj.attr('data-row-command')
      obj.click(() ->
        viewModel[commandHandler](obj)
        false
      )
    )

    $('[data-property]').each(() ->
      obj = $(this)
      propertyName = obj.attr('data-property')
      obj.blur(() ->
        item = viewModel.findItem(obj)
        newValue = obj.val()

        if App.getPropertyByPath(item, propertyName) != newValue
          App.setPropertyByPath(item, propertyName, newValue)

          viewModel.saveProduct(item)
      )
    )

    $('.editUnitOfMeasure').typeahead(
      source: @unitOfMeasures
    )

    $('.editBrand').typeahead(
      source: (query) =>
        _.chain(@allItems)
            .pluck('brand')
            .uniq()
            .value()
    )

    $('.editManufacturer').typeahead(
      source: (query) =>
        _.chain(@allItems)
            .pluck('manufacturer')
            .reject((item) ->
              item == undefined
            )
            .uniq()
            .value()
    )

    $('.editProductGroup').typeahead(
      source: (query) =>
        _.pluck(@globalData.productGroups, 'name')
    )

    $('.editProductSubGroup').typeahead(
      source: @activeProductGroup.subGroups
    )

  addNewRow: () ->
    item = {
      name: 'Ny produkt'
      productGroup: @activeProductGroup.name
      prices: {
      }
    }

    $.ajax(
      type: 'POST'
      url: '/api/product/new'
      contentType: 'application/json'
      data: JSON.stringify(item)

      success: (result) =>
        item.objectId = _.first(result[2]).objectId

        @allItems.push(item)
        @items.push(item)

        # Slightly inefficient to rerender it all, but...
        @renderProductRows()

      error: (result) ->
        alert("Det gick inte att skapa en ny produkt. Felmeddelande: #{result.status} #{result.statusText}")
    )

  deleteRow: (obj) ->
    item = @findItem(obj)

    if confirm("Är det säkert att du vill ta bort '#{item.name}'?")
      $.ajax(
        type: 'DELETE'
        url: '/api/product/' + itemId
        success: (result) =>
          @items.splice(@items.indexOf(item), 1)
          @renderProductRows()
      )

  saveProduct: (product) ->
    $.ajax(
      type: 'PUT'
      url: "/api/product/#{product.objectId}"
      contentType: 'application/json'
      data: JSON.stringify(product)

      error: (result) ->
        alert("Det gick inte att spara produkten. Felmeddelande: #{result.status} #{result.statusText}")
    )

  findItem: (obj) ->
    itemId = obj.parents('tr').attr('data-itemId')
    _.find(@items, (item) -> item.objectId == itemId)

  slugify: (str) ->
    str.replace(/\ /g, '_')
      .replace(/&/g, 'och')
      .replace(/å/g, 'a')
      .replace(/ä/g, 'a')
      .replace(/ö/g, 'o')
      .toLowerCase()

class App.Views.EditProducts.EditProductsView
  templateName: 'views/edit_products/edit_products_view'

  didInsertElement: () ->
    @dataContext.refresh()

    $('a[data-toggle="tab"]').on('show', (e) =>
      anchor = $.url(e.target.href).attr('anchor')
      @dataContext.showProductGroup(anchor)
    )

    # Slightly ugly, but... :)
    $('a[data-toggle="tab"]').first().click()

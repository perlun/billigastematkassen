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
  
  showProductGroup: (groupSlug) ->
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
      
      failure: (errMsg) =>
        $('#nonSpinnerContent').show()
    )

  filterItems: (groupSlug) ->
    @items = _.select(@allItems, (item) =>
      @slugify(item.productGroup) == groupSlug
    )

  renderProductRows: () ->
    html = App.renderTemplate('views/edit_products/edit_products_rows_view', this)
    $('#productRowsContainer').html(html).show()

    # Must be set up after the DOM is completely populated.
    @setupEventHandlers()

    # TODO: Support these again.
#    @grid.attachEvent('onSelectStateChanged', (id) ->
#      $('.deleteRowButton').removeAttr('disabled')
#    )
#    @grid.attachEvent('onAfterRowDeleted', (id, pid) ->
#      $('.deleteRowButton').attr('disabled', 'true')
#    )

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

  addNewRow: () ->
    @grid.addRow(@grid.uid(), [])
    @grid.selectCell(@grid.getRowsNum() - 1, 0, false, false, true)

  deleteRow: ((obj) ->
    if confirm("Är det säkert att du vill ta bort '" + @grid.cells(@grid.getSelectedRowId(), 0).getValue() + "'?")
      @grid.deleteSelectedRows()
  )

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
    $('a[data-toggle="tab"]').on('show', (e) =>
      anchor = $.url(e.target.href).attr('anchor')
      @dataContext.showProductGroup(anchor)
    )

    # Slightly ugly, but... :)
    $('a[data-toggle="tab"]').first().click()

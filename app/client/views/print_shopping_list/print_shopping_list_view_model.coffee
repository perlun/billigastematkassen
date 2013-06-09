#= require ./print_shopping_list_view
#= require ./print_shopping_list_rows_view

App = window.App
App.Views.PrintShoppingList = {}

class App.Views.PrintShoppingList.PrintShoppingListViewModel
  items: []

  refresh: () ->
    App.Spinner.startSpinning('productRowsContainer')

    $.ajax(
      type: 'GET'
      cache: false
      url: '/api/products'
      
      success: (result) =>
        products = eval result
        @items = App.BasketService.mergeBasketItemsWithProducts(products)

        App.Spinner.stopSpinning('productRowsContainer')
        @renderShoppingListRows()
      )

  renderShoppingListRows: () ->
    html = App.renderTemplate('views/print_shopping_list/print_shopping_list_rows_view', this)
    $('#productRowsContainer').html(html).show()    

class App.Views.PrintShoppingList.PrintShoppingListView
  templateName: 'views/print_shopping_list/print_shopping_list_view'

  didInsertElement: () ->
    # Slight tweak, but it's simpler to do it like this than to apply an altogether separate stylesheet just for this page...
    $('body').css('padding', '10px 20px')

    @dataContext.refresh()

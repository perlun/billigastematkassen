#= require ./edit_prices_view

App = window.App

App.Views.EditPrices = {}

App.Views.EditPrices.EditPricesViewModel = Ember.Controller.extend(
  items: []
  unitOfMeasures: [
    'kg',
    'l'
  ]
  productGroups: [
    'Frukt och grönt',
    'Kött & chark',
    'Mejeri & ost',
    'Bageri',
    'Dryck',
    'Glass, godis och snacks',
    'Hem & hygien',
    'Skafferi',
    'Halvfabrikat & färdigmat'
  ]

  init: () ->
    $.ajax(
      type: 'GET'
      cache: false
      url: '/api/prices'
      success: (result) =>
        items = eval result
        items = _.sortBy(items, (i) ->
          "#{i.name}_#{i.brand}"
        )

        @set('items', items)
    )

  addNewRow: () ->
    @items.pushObject({})

  removeRow: (row) ->
    @items.removeObject(row.context)

  saveRows: ->
    $.ajax(
      type: 'POST'
      cache: false
      url: '/api/prices'
      data: JSON.stringify(@get('items'))
      contentType: 'application/json; charset=utf-8'
      dataType: 'json'
      failure: (errMsg) ->
        alert('Ett fel uppstod när priserna skulle sparas: ' + errMsg)
      success: () ->
        alert('Ändringarna har sparats.')
    )
)

App.Views.EditPrices.EditPricesView = Ember.View.extend(
  templateName: ['views/edit_prices/edit_prices_view']
)

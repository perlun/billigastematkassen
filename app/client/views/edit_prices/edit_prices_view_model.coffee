#= require ./edit_prices_view

App = window.App
Spinner = window.Spinner

App.Views.EditPrices = {}

App.Views.EditPrices.EditPricesViewModel = Ember.Controller.extend(
  isWaiting: false
  spinner: new Spinner
  items: []
  unitOfMeasures: [
    'kg',
    'l',
    'st'
  ]
  globalData: App.GlobalData

  init: () ->
    # FIXME: A bit of a hack... For whatever reason, didInsertElement did not work for me.
    Ember.run.next(null, () =>
      return unless @get('isWaiting')
      @spinner.spin($('#spinnerContent').get(0))
    )

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
        @set('isWaiting', false)
        @spinner.stop()
      
      failure: (errMsg) =>
        @set('isWaiting', false)
        @spinner.stop()
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
      failure: (errMsg) =>
        alert('Ett fel uppstod när priserna skulle sparas: ' + errMsg)
        @set('isLoading', false)
      success: () =>
        alert('Ändringarna har sparats.')

    )
)

App.Views.EditPrices.EditPricesView = Ember.View.extend(
  templateName: ['views/edit_prices/edit_prices_view']
)

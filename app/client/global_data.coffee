window.App.GlobalData =  GlobalData =
  productGroups: []
  basketItems: {}

  updateItemCount: () ->
    value = _.reduce(@basketItems, ((memo, num) ->
      memo + num
    ), 0)
    $('#itemCount').html(value)

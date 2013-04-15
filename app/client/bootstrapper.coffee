App = window.App = {}
App.Views = {}
rivets = window.rivets

rivets.configure(
  adapter:
    subscribe: (obj, keypath, callback) ->
      #obj.on('change:' + keypath, callback)

    unsubscribe: (obj, keypath, callback) ->
      #obj.off('change:' + keypath, callback)

    read: (obj, keypath) ->
      if keypath == ''
        obj
      else
        obj[keypath]
      #console.log "obj=#{obj}, keypath=#{keypath}, value=#{value}"
      #value

    publish: (obj, keypath, value) ->
      #obj.set(keypath, value)
)

App.RenderTemplate = (templateName, dataContext) ->
  template = App.Templates[templateName]
  if template?
    _.template(template, dataContext, { variable: 'dataContext' })
  else
    console.error "#{templateName} template not found"

App.Activate = (view, viewModel) ->
  view.willInsertElement() if view.willInsertElement?
  $('#content').html(App.RenderTemplate(view.templateName, viewModel))
  view.didInsertElement() if view.didInsertElement?

App.Spinner = {
  startSpinning: (elementName) ->
    $('#' + elementName).show().spin(
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
    $('#' + elementName).spin(false).hide()
}
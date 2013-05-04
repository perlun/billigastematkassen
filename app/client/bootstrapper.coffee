App = window.App = {}
App.Views = {}

App.RenderTemplate = (templateName, dataContext) ->
  template = App.Templates[templateName]
  if template?
    _.template(template, dataContext, { variable: 'dataContext' })
  else
    console.error "#{templateName} template not found"

App.Activate = (view, viewModel, elementName) ->
  view.willInsertElement() if view.willInsertElement?
  $(elementName || '#content').html(App.RenderTemplate(view.templateName, viewModel))
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
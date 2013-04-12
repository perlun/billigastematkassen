App = window.App = {}
App.Views = {}

App.RenderTemplate = (templateName, dataContext) ->
  _.template(App.Templates[templateName], dataContext, { variable: 'dataContext' })

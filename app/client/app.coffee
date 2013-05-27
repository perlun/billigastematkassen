class App
  elementViewModels: {}
  elementViews: {}

  Views: {}

  Spinner: {
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

  renderTemplate: (templateName, dataContext) ->
    template = @templates[templateName]
    if template?
      _.template(template, dataContext, { variable: 'dataContext' })
    else
      console.error "#{templateName} template not found"

  activate: (viewClass, viewModelClass, elementName, parameters...) ->
    elementName ||= '#content'

    if viewModelClass &&
       @elementViewModels[elementName]?.constructor.name == _.last(viewModelClass.name.split('.'))
      viewModel = @elementViewModels[elementName]
    else
      view = new viewClass

      if viewModelClass
        viewModel = new viewModelClass 
        view.dataContext = viewModel

      view.willInsertElement() if view.willInsertElement?
      $(elementName).html(@renderTemplate(view.templateName, viewModel)).show()
      view.didInsertElement() if view.didInsertElement?

      previousView = @elementViews[elementName]
      if previousView != view && previousView?.didRemoveElement
        previousView.didRemoveElement()

      @elementViewModels[elementName] = viewModel
      @elementViews[elementName] = view

    viewModel.setParameters(parameters...) if viewModel?.setParameters?

  getPropertyByPath: (obj, path) ->
    path = path.split('.')
    parent = obj

    if path.length > 1
      parent = parent[path[i]] for i in [0..path.length - 2]
      
    parent?[path[path.length - 1]]

  setPropertyByPath: (obj, path, value) ->
    path = path.split('.')
    parent = obj

    if path.length > 1
      parent = (parent[path[i]] ||= {}) for i in [0..path.length - 2]

    parent[path[path.length - 1]] = value

  slugify: (str) ->
    return nil unless str?

    str
      .replace(/,/g, '')
      .replace(/\ /g, '_')
      .replace(/&/g, 'och')
      .replace(/å/g, 'a')
      .replace(/ä/g, 'a')
      .replace(/ö/g, 'o')
      .toLowerCase()    

window.App = new App()

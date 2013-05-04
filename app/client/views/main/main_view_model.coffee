#= require views/main/main_view

App = window.App
App.Views.Main = {}

class App.Views.Main.MainViewModel
  globalData: App.GlobalData

  constructor: () ->
    $(window).on('hashchange', @handleHashChange)

  handleHashChange: () ->
    $('.nav-collapse > .nav > li').removeClass('active')
    $(".nav-collapse > .nav > li > a[href='#{location.hash}']").each((i, el) ->
      $(el).parent().addClass('active')
    )

class App.Views.Main.MainView
  templateName: 'views/main/main_view'

  didInsertElement: () ->
    @dataContext.handleHashChange()

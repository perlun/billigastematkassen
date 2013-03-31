@App = Ember.Application.create()

@App.Views = {}

@App.ApplicationController = Ember.Controller.extend({
  pricesLinkClass: false
  editLinkClass: false

  init: () ->
    window.addEventListener("hashchange", (event) =>
      @updateActiveClasses event.newURL
    false)

    # Must call for initial URL also.
    @updateActiveClasses window.location

  updateActiveClasses: (url) ->
    parsedUrl = $.url(url)

    fragment = parsedUrl.attr('fragment')
    @set('pricesLinkClass', (if fragment == '' then 'active' else ''))
    @set('editLinkClass', (if fragment == '/redigera' then 'active' else ''))
})

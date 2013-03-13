// Generated by CoffeeScript 1.6.1
(function() {
  var App;

  App = Ember.Application.create();

  App.Views = {};

  App.Views.Prices = {};

  App.Views.Prices.PricesView = Ember.View.extend({
    templateName: 'prices'
  });

  App.Router = Ember.Router.extend({
    root: Ember.Route.extend({
      index: Ember.Route.extend({
        route: '/',
        connectOutlets: function(router, context) {
          var ctrl;
          ctrl = router.get('applicationController');
          return ctrl.connectOutlet({
            viewClass: App.Views.Prices.PricesView,
            outletName: 'prices'
          });
        }
      })
    })
  });

  App.ApplicationController = Ember.Controller.extend();

  App.initialize();

}).call(this);
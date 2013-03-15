// Generated by CoffeeScript 1.6.1
(function() {
  var App;

  App = Ember.Application.create();

  App.Views = {};

  App.Views.Prices = {};

  App.Views.Prices.PricesController = Ember.Controller.extend({
    items: [],
    init: function() {
      var _this = this;
      return $.ajax({
        type: 'GET',
        cache: false,
        url: '/api/prices',
        success: function(result) {
          return _this.set('items', eval(result));
        }
      });
    }
  });

  App.Views.Prices.PricesView = Ember.View.extend({
    templateName: 'prices',
    init: function() {
      var controller;
      this._super();
      controller = App.Views.Prices.PricesController.create();
      this.set('_context', controller);
      return this.set('controller', controller);
    }
  });

  App.Router = Ember.Router.extend({
    root: Ember.Route.extend({
      index: Ember.Route.extend({
        route: '/',
        connectOutlets: function(router, context) {
          var ctrl;
          ctrl = router.get('applicationController');
          ctrl.disconnectOutlet('content');
          return ctrl.connectOutlet({
            viewClass: App.Views.Prices.PricesView,
            outletName: 'content'
          });
        }
      }),
      admin: Ember.Route.extend({
        route: '/redigera',
        connectOutlets: function(router, context) {
          var ctrl;
          ctrl = router.get('applicationController');
          return ctrl.disconnectOutlet('content');
        }
      })
    })
  });

  App.ApplicationController = Ember.Controller.extend();

  App.initialize();

}).call(this);

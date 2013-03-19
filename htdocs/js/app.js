var App;

App = Ember.Application.create();

App.Views = {};

App.Views.Prices = {};

App.Controls = {};

App.Controls.MoneyTextField = Ember.TextField.extend({
  type: 'number',
  attributeBindings: ['step', 'style'],
  step: 0.01,
  size: 5,
  style: 'width: 60px; padding: 0px 6px;'
});

App.Controls.AmountTextField = Ember.TextField.extend({
  type: 'number',
  attributeBindings: ['step', 'style'],
  step: 0.001,
  size: 5,
  style: 'width: 60px; padding: 0px 6px;'
});

App.Views.Prices.PricesViewModel = Ember.Controller.extend({
  items: [],
  init: function() {
    var _this = this;

    return $.ajax({
      type: 'GET',
      cache: false,
      url: '/api/prices',
      success: function(result) {
        var items;

        items = eval(result);
        _.each(items, function(i) {
          return i.imageUrl = "/img/items/" + i.name + "_" + (_this.localizeValue(i.qty)) + "_" + i.unitOfMeasure + "_" + i.brand + ".jpg";
        });
        console.log(items);
        return _this.set('items', items);
      }
    });
  },
  localizeValue: function(s) {
    return s != null ? s.replace('.', ',') : void 0;
  }
});

App.Views.Prices.PricesView = Ember.View.extend({
  templateName: 'prices',
  init: function() {
    var controller;

    this._super();
    controller = App.Views.Prices.PricesViewModel.create();
    this.set('_context', controller);
    return this.set('controller', controller);
  }
});

App.Views.Prices.EditPricesViewModel = Ember.Controller.extend({
  items: [],
  unitOfMeasures: ['kg', 'l'],
  productGroups: ['Frukt och grönt', 'Kött & chark', 'Mejeri & ost', 'Bageri', 'Dryck', 'Glass, godis och snacks', 'Hem & hygien', 'Skafferi', 'Halvfabrikat & färdigmat'],
  init: function() {
    var _this = this;

    return $.ajax({
      type: 'GET',
      cache: false,
      url: '/api/prices',
      success: function(result) {
        var items;

        items = eval(result);
        items = _.sortBy(items, function(i) {
          return "" + i.name + "_" + i.brand;
        });
        return _this.set('items', items);
      }
    });
  },
  addNewRow: function() {
    return this.items.pushObject({});
  },
  removeRow: function(row) {
    return this.items.removeObject(row.context);
  },
  saveRows: function() {
    return $.ajax({
      type: 'POST',
      cache: false,
      url: '/api/prices',
      data: JSON.stringify(this.get('items')),
      contentType: 'application/json; charset=utf-8',
      dataType: 'json',
      failure: function(errMsg) {
        return alert('Ett fel uppstod när priserna skulle sparas: ' + errMsg);
      },
      success: function() {
        return alert('Ändringarna har sparats.');
      }
    });
  }
});

App.Views.Prices.EditPricesView = Ember.View.extend({
  templateName: 'edit_prices',
  init: function() {
    var controller;

    this._super();
    controller = App.Views.Prices.EditPricesViewModel.create();
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
        ctrl.disconnectOutlet('content');
        return ctrl.connectOutlet({
          viewClass: App.Views.Prices.EditPricesView,
          outletName: 'content'
        });
      }
    })
  })
});

App.ApplicationController = Ember.Controller.extend({
  pricesLinkClass: false,
  editLinkClass: false,
  init: function() {
    var _this = this;

    window.addEventListener("hashchange", function(event) {
      return _this.updateActiveClasses(event.newURL);
    }, false);
    return this.updateActiveClasses(window.location);
  },
  updateActiveClasses: function(url) {
    var fragment, parsedUrl;

    parsedUrl = $.url(url);
    fragment = parsedUrl.attr('fragment');
    this.set('pricesLinkClass', (fragment === '' ? 'active' : ''));
    return this.set('editLinkClass', (fragment === '/redigera' ? 'active' : ''));
  }
});

App.initialize();

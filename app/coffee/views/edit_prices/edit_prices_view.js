(function() {
  var template = Handlebars.template, templates = Handlebars.templates = Handlebars.templates || {};
templates['edit_prices_view'] = template(function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [2,'>= 1.0.0-rc.3'];
helpers = helpers || Handlebars.helpers; data = data || {};
  var buffer = "", stack1, options, helperMissing=helpers.helperMissing, escapeExpression=this.escapeExpression, self=this;

function program1(depth0,data) {
  
  var buffer = "", stack1, options;
  buffer += "\n      <tr>\n        <td>";
  options = {hash:{
    'valueBinding': ("item.name"),
    'classNames': ("editName")
  },data:data};
  buffer += escapeExpression(((stack1 = helpers.view),stack1 ? stack1.call(depth0, ((stack1 = depth0.Ember),stack1 == null || stack1 === false ? stack1 : stack1.TextField), options) : helperMissing.call(depth0, "view", ((stack1 = depth0.Ember),stack1 == null || stack1 === false ? stack1 : stack1.TextField), options)))
    + "</td>\n        <td>";
  options = {hash:{
    'valueBinding': ("item.qty")
  },data:data};
  buffer += escapeExpression(((stack1 = helpers.view),stack1 ? stack1.call(depth0, ((stack1 = ((stack1 = depth0.App),stack1 == null || stack1 === false ? stack1 : stack1.Controls)),stack1 == null || stack1 === false ? stack1 : stack1.AmountTextField), options) : helperMissing.call(depth0, "view", ((stack1 = ((stack1 = depth0.App),stack1 == null || stack1 === false ? stack1 : stack1.Controls)),stack1 == null || stack1 === false ? stack1 : stack1.AmountTextField), options)))
    + "</td>\n        <td>";
  options = {hash:{
    'contentBinding': ("unitOfMeasures"),
    'prompt': (" "),
    'valueBinding': ("item.unitOfMeasure"),
    'classNames': ("editQty")
  },data:data};
  buffer += escapeExpression(((stack1 = helpers.view),stack1 ? stack1.call(depth0, ((stack1 = depth0.Ember),stack1 == null || stack1 === false ? stack1 : stack1.Select), options) : helperMissing.call(depth0, "view", ((stack1 = depth0.Ember),stack1 == null || stack1 === false ? stack1 : stack1.Select), options)))
    + "</td>\n        <td>";
  options = {hash:{
    'valueBinding': ("item.brand"),
    'classNames': ("editBrand")
  },data:data};
  buffer += escapeExpression(((stack1 = helpers.view),stack1 ? stack1.call(depth0, ((stack1 = depth0.Ember),stack1 == null || stack1 === false ? stack1 : stack1.TextField), options) : helperMissing.call(depth0, "view", ((stack1 = depth0.Ember),stack1 == null || stack1 === false ? stack1 : stack1.TextField), options)))
    + "</td>\n        <td>";
  options = {hash:{
    'valueBinding': ("item.manufacturer"),
    'classNames': ("editBrand")
  },data:data};
  buffer += escapeExpression(((stack1 = helpers.view),stack1 ? stack1.call(depth0, ((stack1 = depth0.Ember),stack1 == null || stack1 === false ? stack1 : stack1.TextField), options) : helperMissing.call(depth0, "view", ((stack1 = depth0.Ember),stack1 == null || stack1 === false ? stack1 : stack1.TextField), options)))
    + "</td>\n        <td>";
  options = {hash:{
    'contentBinding': ("productGroups"),
    'prompt': (" "),
    'valueBinding': ("item.productGroup"),
    'classNames': ("editProductGroup")
  },data:data};
  buffer += escapeExpression(((stack1 = helpers.view),stack1 ? stack1.call(depth0, ((stack1 = depth0.Ember),stack1 == null || stack1 === false ? stack1 : stack1.Select), options) : helperMissing.call(depth0, "view", ((stack1 = depth0.Ember),stack1 == null || stack1 === false ? stack1 : stack1.Select), options)))
    + "</td>\n        <td>";
  options = {hash:{
    'valueBinding': ("item.price_axet")
  },data:data};
  buffer += escapeExpression(((stack1 = helpers.view),stack1 ? stack1.call(depth0, ((stack1 = ((stack1 = depth0.App),stack1 == null || stack1 === false ? stack1 : stack1.Controls)),stack1 == null || stack1 === false ? stack1 : stack1.MoneyTextField), options) : helperMissing.call(depth0, "view", ((stack1 = ((stack1 = depth0.App),stack1 == null || stack1 === false ? stack1 : stack1.Controls)),stack1 == null || stack1 === false ? stack1 : stack1.MoneyTextField), options)))
    + "</td>\n        <td>";
  options = {hash:{
    'valueBinding': ("item.price_citymarket")
  },data:data};
  buffer += escapeExpression(((stack1 = helpers.view),stack1 ? stack1.call(depth0, ((stack1 = ((stack1 = depth0.App),stack1 == null || stack1 === false ? stack1 : stack1.Controls)),stack1 == null || stack1 === false ? stack1 : stack1.MoneyTextField), options) : helperMissing.call(depth0, "view", ((stack1 = ((stack1 = depth0.App),stack1 == null || stack1 === false ? stack1 : stack1.Controls)),stack1 == null || stack1 === false ? stack1 : stack1.MoneyTextField), options)))
    + "</td>\n        <td>";
  options = {hash:{
    'valueBinding': ("item.price_lidl")
  },data:data};
  buffer += escapeExpression(((stack1 = helpers.view),stack1 ? stack1.call(depth0, ((stack1 = ((stack1 = depth0.App),stack1 == null || stack1 === false ? stack1 : stack1.Controls)),stack1 == null || stack1 === false ? stack1 : stack1.MoneyTextField), options) : helperMissing.call(depth0, "view", ((stack1 = ((stack1 = depth0.App),stack1 == null || stack1 === false ? stack1 : stack1.Controls)),stack1 == null || stack1 === false ? stack1 : stack1.MoneyTextField), options)))
    + "</td>\n        <td>";
  options = {hash:{
    'valueBinding': ("item.price_minimani")
  },data:data};
  buffer += escapeExpression(((stack1 = helpers.view),stack1 ? stack1.call(depth0, ((stack1 = ((stack1 = depth0.App),stack1 == null || stack1 === false ? stack1 : stack1.Controls)),stack1 == null || stack1 === false ? stack1 : stack1.MoneyTextField), options) : helperMissing.call(depth0, "view", ((stack1 = ((stack1 = depth0.App),stack1 == null || stack1 === false ? stack1 : stack1.Controls)),stack1 == null || stack1 === false ? stack1 : stack1.MoneyTextField), options)))
    + "</td>\n        <td>";
  options = {hash:{
    'valueBinding': ("item.price_prisma")
  },data:data};
  buffer += escapeExpression(((stack1 = helpers.view),stack1 ? stack1.call(depth0, ((stack1 = ((stack1 = depth0.App),stack1 == null || stack1 === false ? stack1 : stack1.Controls)),stack1 == null || stack1 === false ? stack1 : stack1.MoneyTextField), options) : helperMissing.call(depth0, "view", ((stack1 = ((stack1 = depth0.App),stack1 == null || stack1 === false ? stack1 : stack1.Controls)),stack1 == null || stack1 === false ? stack1 : stack1.MoneyTextField), options)))
    + "</td>\n        <td><a href=\"#\" ";
  options = {hash:{},data:data};
  buffer += escapeExpression(((stack1 = helpers.action),stack1 ? stack1.call(depth0, "removeRow", depth0.item, options) : helperMissing.call(depth0, "action", "removeRow", depth0.item, options)))
    + "><i class=\"icon-trash\"></i></a></td>\n      </tr>\n      ";
  return buffer;
  }

  buffer += "<div>\n  <h1>Billigaste Matkassen - Redigera priser</h1>\n</div>      \n\n<form>\n  <table class=\"table table-striped table-hover table-condensed\">\n    <thead>\n      <tr>\n        <th>Artikel</th>\n        <th>Vikt/volym</th>\n        <th>Enhet</th>\n        <th>Varumärke</th>\n        <th>Tillverkare</th>\n        <th>Produktgrupp</th>\n        <th>Axet</th>\n        <th>Citymarket</th>\n        <th>Lidl</th>\n        <th>Minimani</th>\n        <th>Prisma</th>\n      </tr>\n    </thead>\n    <tbody>\n      ";
  stack1 = helpers.each.call(depth0, depth0.item, depth0['in'], depth0.items, {hash:{},inverse:self.noop,fn:self.program(1, program1, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n    </tbody>\n  </table>\n\n  <div>\n    <button class=\"btn\" ";
  options = {hash:{},data:data};
  buffer += escapeExpression(((stack1 = helpers.action),stack1 ? stack1.call(depth0, depth0.addNewRow, options) : helperMissing.call(depth0, "action", depth0.addNewRow, options)))
    + ">Lägg till ny rad</button>\n  </div>\n  <div style=\"margin-top: 12px;\">\n    <button class=\"btn\" ";
  options = {hash:{},data:data};
  buffer += escapeExpression(((stack1 = helpers.action),stack1 ? stack1.call(depth0, depth0.saveRows, options) : helperMissing.call(depth0, "action", depth0.saveRows, options)))
    + ">Spara</button>\n  </div>\n</form>\n";
  return buffer;
  });
})();

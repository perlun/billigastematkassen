App.templates = App.templates || {};
App.templates['views/list_products/product_sub_groups_view'] = '<ul class="nav nav-list">  <li class="nav-header">Undergrupper</li>   <% _.each(dataContext.productGroup.subGroups, function(subGroup) { %>   <li><a href="#/produkter/<%= dataContext.productGroup.slug %>/<%= App.slugify(subGroup) %>"><%= subGroup %></a></li>   <% }); %>  <li>  </li></ul>';

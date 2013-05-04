App.Templates = App.Templates || {};
App.Templates['views/list_products/list_products_view'] = '<ul class="nav nav-tabs">  <% _.each(dataContext.globalData.productGroups, function(group) { %>  <li>    <a href="#<%= group.slug %>" data-toggle="tab"><%= group.name %></a>  </li>  <% }); %></ul><div id="productRowsContainer" style="min-height: 300px;"></div><div id="modalContainer"/>';

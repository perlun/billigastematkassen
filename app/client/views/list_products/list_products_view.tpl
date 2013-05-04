<ul class="nav nav-tabs">
  <% _.each(dataContext.globalData.productGroups, function(group) { %>
  <li>
    <a href="#<%= group.slug %>" data-toggle="tab"><%= group.name %></a>
  </li>
  <% }); %>
</ul>

<div id="productRowsContainer" style="min-height: 300px;">
</div>

<div id="modalContainer"/>

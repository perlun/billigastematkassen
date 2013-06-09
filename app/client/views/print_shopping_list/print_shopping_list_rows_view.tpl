<%

groupedItems = _.groupBy(dataContext.items, 'productGroup');
_.each(groupedItems, function(items, groupName) { 

%>
<h3><%= groupName %></h3>
<%

  subGroupedItems = _.groupBy(items, 'productSubGroup');
  _.each(subGroupedItems, function(subItems, subGroupName) {

%>
<h4><%= subGroupName %></h4>
<ul>
  <% _.each(subItems, function(subItem) { %>
  <li><%= subItem.name %></li>
  <% }); %>
</ul>
<% 

  });
}); 

%>
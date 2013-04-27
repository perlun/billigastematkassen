<table class="table table-striped table-hover table-condensed">
  <thead>
    <tr>
      <th>Artikel</th>
      <th>Antal</th>
      <th>Varumärke</th>
      <th>Tillverkare</th>
      <th>Produktgrupp</th>
      <th>Axet</th>
      <th>Citymarket</th>
      <th>Minimani</th>
      <th>Prisma</th>
    </tr>
  </thead>
  <tbody>
    <% _.each(dataContext.items, function(item) { %>
    <tr data-itemId="<%= item.itemId %>">
      <td><%= item.name %> (<%= item.qty %> <%= item.unitOfMeasure %>)</td>
      <td><input type="text" value="<%= item.count %>" class="editQty" /></td>
      <td><%= item.brand %></td>
      <td><%= item.manufacturer %></td>
      <td><%= item.productGroup %></td>
      <% if (item.prices !== undefined) { %>
      <td><%= item.prices.axet %></td>
      <td><%= item.prices.citymarket %></td>
      <td><%= item.prices.minimani %></td>
      <td><%= item.prices.prisma %></td>
      <% } else { %>
      <td colspan="4">&nbsp;</td>
      <% } %>
    </tr>
    <% }); %>
  </tbody>
</table>

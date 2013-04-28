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
      <td class="price"><%= item.prices.axet %></td>
      <td class="price"><%= item.prices.citymarket %></td>
      <td class="price"><%= item.prices.minimani %></td>
      <td class="price"><%= item.prices.prisma %></td>
      <% } else { %>
      <td colspan="4">&nbsp;</td>
      <% } %>
    </tr>
    <% }); %>
  </tbody>
  <tfoot>
    <tr>
      <th colspan="5"></td>
      <th id="axetPricesSum" class="price"></td>
      <th id="citymarketPricesSum" class="price"></td>
      <th id="minimaniPricesSum" class="price"></td>
      <th id="prismaPricesSum" class="price"></td>
    </tr>
  </tfoot>
</table>

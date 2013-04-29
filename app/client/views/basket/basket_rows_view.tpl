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
    <tr data-itemId="<%= item.objectId %>">
      <td><%= item.name %> (<%= item.qty %> <%= item.unitOfMeasure %>)</td>
      <td><input type="text" value="<%= item.count %>" class="editQty" data-count="true" /></td>
      <td><%= item.brand %></td>
      <td><%= item.manufacturer %></td>
      <td><%= item.productGroup %></td>
      <% if (item.prices !== undefined) { %>
      <td class="price <%= item.lowestPriceType == 'axet' ? 'lowestPrice' : '' %>"><%= item.prices.axet %></td>
      <td class="price <%= item.lowestPriceType == 'citymarket' ? 'lowestPrice' : '' %>"><%= item.prices.citymarket %></td>
      <td class="price <%= item.lowestPriceType == 'minimani' ? 'lowestPrice' : '' %>"><%= item.prices.minimani %></td>
      <td class="price <%= item.lowestPriceType == 'prisma' ? 'lowestPrice' : '' %>"><%= item.prices.prisma %></td>
      <% } else { %>
      <td colspan="4">&nbsp;</td>
      <% } %>
      <td><a href="#" data-command="deleteRow"><i class="icon-trash"></i></a></td>
    </tr>
    <% }); %>
  </tbody>
  <tfoot>
    <tr>
      <th colspan="5"></th>
      <th id="axetPricesSum" class="price"></th>
      <th id="citymarketPricesSum" class="price"></th>
      <th id="minimaniPricesSum" class="price"></th>
      <th id="prismaPricesSum" class="price"></th>
      <th id="noPricesSum" colspan="4"></th>
    </tr>
  </tfoot>
</table>

<div>
  <input type="button" class="btn" value="Töm varukorgen" data-command="clearBasket"/>
</div>
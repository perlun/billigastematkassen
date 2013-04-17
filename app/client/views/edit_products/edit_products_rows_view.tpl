  <div>
    <table id="productRowsTable" style="white-space: nowrap;">
      <thead>
        <tr>
          <th>Artikel</th>
          <th>Vikt/volym</th>
          <th>Enhet</th>
          <th>Varumärke</th>
          <th>Tillverkare</th>
          <th>Produktgrupp</th>
          <th>Axet</th>
          <th>Citymarket</th>
          <th>Lidl</th>
          <th>Minimani</th>
          <th>Prisma</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        <% _.each(dataContext.items, function(item) { %>
        <tr data-slug="<%= item.slug %>">
          <td><%= item.name %></td>
          <td><%= item.qty %></td>
          <td><%= item.unitOfMeasure %></td>
          <td><%= item.brand %></td>
          <td><%= item.manufacturer %></td>
          <td><%= item.productGroup %></td>
          <td><%= item.price_axet %></td>
          <td><%= item.price_citymarket %></td>
          <td><%= item.price_lidl %></td>
          <td><%= item.price_minimani %></td>
          <td><%= item.price_prisma %></td>
          <td><a href="#" data-command="deleteRow"><i class="icon-trash"></i></a></td>
        </tr>
        <% }); %>
      </tbody>
    </table>
  </div>

  <div style="margin-top: 36px;">
    <button class="btn" data-command="addNewRow">Lägg till ny rad</button>
  </div>

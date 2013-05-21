  <table class="table table-striped table-hover table-condensed">
    <thead>
      <tr>
        <th>Artikel</th>
        <th colspan="2">Vikt/volym</th>
        <th>Varumärke</th>
        <th>Tillverkare</th>
        <th>Produktgrupp</th>
        <th>Sale Solf</th>
        <th>Citymarket<br/>Stenhaga</th>
        <th>Minimani</th>
        <th>Prisma</th>
      </tr>
    </thead>
    <tbody>
      <% _.each(dataContext.items, function(item) { %>
      <tr data-itemId="<%= item.objectId %>">
        <td><input type="text" class="editName" value="<%= item.name %>"/></td>
        <td><input type="text" class="editQty" value="<%= item.qty %>"/></td>
        <td><input type="text" class="editUnitOfMeasure" value="<%= item.unitOfMeasure %>"/></td>
        <td><input type="text" class="editBrand" value="<%= item.brand %>"/></td>
        <td><input type="text" class="editManufacturer" value="<%= item.manufacturer %>"/></td>
        <td><input type="text" class="editProductGroup" value="<%= item.productGroup %>"/></td>
        <td><input type="text" class="editPrice" value="<%= item.prices.saleSolf %>"/></td>
        <td><input type="text" class="editPrice" value="<%= item.prices.citymarket %>"/></td>
        <td><input type="text" class="editPrice" value="<%= item.prices.minimani %>"/></td>
        <td><input type="text" class="editPrice" value="<%= item.prices.prisma %>"/></td>
        <td><a href="#" data-row-command="deleteRow"><i class="icon-trash"></i></a></td>
      </tr>
      <% }); %>
    </tbody>
  </table>

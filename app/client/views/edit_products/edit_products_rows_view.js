App.templates = App.templates || {};
App.templates['views/edit_products/edit_products_rows_view'] = '  <table class="table table-striped table-hover table-condensed">    <thead>      <tr>        <th>Artikel</th>        <th colspan="2">Vikt/volym</th>        <th>Varumärke</th>        <% if (dataContext.mode == \'products\') { %>        <th>Tillverkare</th>        <th>Produktgrupp</th>        <th>Undergrupp</th>        <% } %>        <% if (dataContext.mode == \'prices\') { %>        <th>Sale Solf</th>        <th>Citymarket<br/>Stenhaga</th>        <th>Minimani</th>        <th>Prisma</th>        <% } %>      </tr>    </thead>    <tbody>      <% _.each(dataContext.items, function(item) { %>      <tr data-itemId="<%= item.objectId %>">        <% if (dataContext.mode == \'products\') { %>        <td><input type="text" class="editName" value="<%= item.name %>" data-property="name" /></td>        <td><input type="text" class="editQty" value="<%= item.qty %>" data-property="qty" /></td>        <td><input type="text" class="editUnitOfMeasure" value="<%= item.unitOfMeasure %>" data-property="unitOfMeasure" /></td>        <td><input type="text" class="editBrand" value="<%= item.brand %>" data-property="brand" /></td>        <td><input type="text" class="editManufacturer" value="<%= item.manufacturer %>" data-property="manufacturer" /></td>        <td><input type="text" class="editProductGroup" value="<%= item.productGroup %>" data-property="productGroup" /></td>        <td><input type="text" class="editProductSubGroup" value="<%= item.productSubGroup %>" data-property="productSubGroup" /></td>        <% } %>        <% if (dataContext.mode == \'prices\') { %>        <td><%= item.name %></td>        <td><%= item.qty %></td>        <td><%= item.unitOfMeasure %></td>        <td><%= item.brand %></td>        <td><input type="text" class="editPrice" value="<%= item.prices.saleSolf %>" data-property="prices.saleSolf" /></td>        <td><input type="text" class="editPrice" value="<%= item.prices.citymarket %>" data-property="prices.citymarket" /></td>        <td><input type="text" class="editPrice" value="<%= item.prices.minimani %>" data-property="prices.minimani" /></td>        <td><input type="text" class="editPrice" value="<%= item.prices.prisma %>" data-property="prices.prisma" /></td>        <% } %>        <td><a href="#" data-row-command="deleteRow"><i class="icon-trash"></i></a></td>      </tr>      <% }); %>    </tbody>  </table>';

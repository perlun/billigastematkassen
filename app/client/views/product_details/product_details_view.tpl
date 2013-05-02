<div style="margin: 12px;">
  <div style="position: absolute; bottom: 6px; text-align: right;"><a href="#" data-command="addToBasket" data-itemId="<%= dataContext.product.objectId %>">Lägg till</a></div>

  <% if (dataContext.product.imageUrl) { %>
  <div class="thumbnailImageContainer">
    <img src="<%= dataContext.product.imageUrl %>"/>
  </div>
  <% } %>

  <h2><%= dataContext.product.name %></h2>

  <div><%= dataContext.product.qty %> <%= dataContext.product.unitOfMeasure %> <%= dataContext.product.brand %> (<%= dataContext.product.productGroup %>)</div>

  <table class="table table-striped table-hover table-condensed">
    <thead>
      <tr>
        <th>Axet</th>
        <th>Citymarket</th>
        <th>Minimani</th>
        <th>Prisma</th>
      </tr>
    </thead>
  </tbody>
  <tbody>
    <tr>
      <% if (dataContext.product.prices) { %>
      <td><%= dataContext.product.prices.axet %></td>
      <td><%= dataContext.product.prices.citymarket %></td>
      <td><%= dataContext.product.prices.minimani %></td>
      <td><%= dataContext.product.prices.prisma %></td>
      <% } else { %>
      <td colspan="4"></td>
      <% } %>
    </tr>
  </tbody>
</div>
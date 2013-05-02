<ul class="thumbnails">
  <% _.each(dataContext.filteredItems, function(item) { %>
  <li class="span2">
    <div class="thumbnail" style="height: 240px;">
      <div style="position: relative; top: 220px; text-align: right;"><a href="#" data-command="addToBasket" data-itemId="<%= item.objectId %>">Lägg till</a></div>

      <a href="#" style="color: black;" data-command="showProductDetails" data-itemId="<%= item.objectId %>">
        <% if (item.imageUrl) { %>
        <div class="thumbnailImageContainer">
          <img src="<%= item.imageUrl %>"/>
        </div>
        <% } else { %>
        <div style="margin-bottom: 12px; text-align: center;">
          <i class="icon-question-sign" style="font-size: 5em; height: 150px;"></i>
        </div>
        <% } %>
        <div style="font-weight: bold; overflow: hidden; text-overflow: clip; height: 19px;"><%= item.name %></div>
        <div><%= item.qty %> <%= item.unitOfMeasure %> <%= item.brand %></div>
      </a>
    </div>
  </li>  
  <% }); %>
</ul>

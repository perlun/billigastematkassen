<input type="button" class="btn" value="Lägg till alla" data-command="addAllToBasket"/>

<ul class="thumbnails">
  <% _.each(dataContext.filteredItems, function(item) { %>
  <li class="span2">
    <div class="thumbnail" style="height: 240px;">
      <div style="position: relative; top: 215px; text-align: right;"><a href="#" class="btn btn-success btn-small" data-command="addToBasket" data-itemId="<%= item.objectId %>">Lägg till</a></div>

      <a href="#" style="color: black;" data-command="showProductDetails" data-itemId="<%= item.objectId %>">
        <% if (item.imageUrl) { %>
        <div class="thumbnailImageContainer">
          <img src="thumbnail<%= item.imageUrl %>?width=117&amp;height=130"/>
        </div>
        <% } else { %>
        <div style="margin-bottom: 12px; text-align: center;">
          <i class="icon-question-sign" style="font-size: 5em; height: 130px;"></i>
        </div>
        <% } %>
        <div class="name"><%= item.name %></div>
        <div><%= item.qty %> <%= item.unitOfMeasure %> <%= item.brand %></div>
      </a>
    </div>
  </li>  
  <% }); %>
</ul>

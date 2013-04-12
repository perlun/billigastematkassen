<ul class="thumbnails">
  <% _.each(dataContext.filteredItems, function(item) { %>
  <li class="span2">
    <a {{bindAttr href="item.detailsAnchor"}} class="nolink" style="color: #333333;">
      <div class="thumbnail" style="height: 240px; cursor: pointer;">
        <% if (item.imageUrl) { %>
        <div class="thumbnailImageContainer">
          <img src="<%= item.imageUrl %>"/>
        </div>
        <% } else { %>
        <div style="margin-bottom: 12px; text-align: center;">
          <i class="icon-question-sign" style="font-size: 5em; height: 150px;"></i>
        </div>
        <% } %>
        <div style="font-weight: bold; word-wrap: break-word;"><%= item.name %></div>
        <div><%= item.qty %> <%= item.unitOfMeasure %> <%= item.brand %></div>
      </div>
    </a>
  </li>  
  <% }); %>
</ul>

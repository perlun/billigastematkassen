<div>
  <h1>Billigaste Matkassen - Priser</h1>
  <p>
    Denna sida hjälper dig att hitta det billigaste priset på din matkasse, baserat på priser som har registrerats på <a href="#/redigera">redigeringssidan</a>.
  </p>
</div>

<ul class="nav nav-tabs">
  <% _.each(dataContext.globalData.productGroups, function(group) { %>
  <li>
    <a href="<%= group.tabSlug %>" data-toggle="tab"><%= group.description %></a>
  </li>
  <% }); %>
</ul>

<!-- FIXME: Wait with rendering this until we are ready with our Ajax request. -->
<ul class="thumbnails">
  {{#each item in filteredItems}}
  <li class="span2">
    <a {{bindAttr href="item.detailsAnchor"}} class="nolink" style="color: #333333;">
      <div class="thumbnail" style="height: 240px; cursor: pointer;">
        {{#if item.imageUrl}}
        <div class="thumbnailImageContainer">
          <img {{bindAttr src="item.imageUrl"}}/>
        </div>
        {{else}}
        <div style="margin-bottom: 12px; text-align: center;">
          <i class="icon-question-sign" style="font-size: 5em; height: 150px;"></i>
        </div>                  
        {{/if}}
        <div style="font-weight: bold; word-wrap: break-word;">{{item.name}}</div>
        <div>{{item.qty}} {{item.unitOfMeasure}} {{item.brand}}</div>
      </div>
    </a>
  </li>
  {{/each}}
</ul>

<div id="modalContainer"/>

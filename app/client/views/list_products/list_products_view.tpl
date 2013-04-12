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
<div id="productRowsContainer" style="min-height: 300px;">
</div>

<div id="modalContainer"/>

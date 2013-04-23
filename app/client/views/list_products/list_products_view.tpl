<div>
  <h1>Billigaste Matkassen - Priser</h1>
  <p>
    Denna sida hjälper dig att hitta det billigaste priset på din matkasse, baserat på priser som har registrerats på <a href="#/redigera">redigeringssidan</a>.
  </p>
</div>

<ul class="nav nav-tabs">
  <% _.each(dataContext.globalData.productGroups, function(group) { %>
  <li>
    <a href="#<%= group.slug %>" data-toggle="tab"><%= group.name %></a>
  </li>
  <% }); %>
</ul>

<div id="productRowsContainer" style="min-height: 300px;">
</div>

<div id="modalContainer"/>

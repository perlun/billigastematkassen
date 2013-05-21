<div>
  <h1>Billigaste Matkassen - Redigera priser</h1>
</div>      

<div id="spinnerContent" style="min-height: 300px; display: none;">
</div>

<div id="nonSpinnerContent">
  <ul class="nav nav-tabs">
    <% _.each(dataContext.globalData.productGroups, function(group) { %>
    <li>
      <a href="#<%= group.slug %>" data-toggle="tab"><%= group.name %></a>
    </li>
    <% }); %>
  </ul>

  <div style="margin-bottom: 12px;">
    <input type="button"
           class="btn"
           data-command="addNewRow"
           value="Ny rad" />
  </div>

  <div id="productRowsContainer"></div>

  <div style="margin: 12px 0 18px 0;">
    <input type="button"
           class="btn"
           data-command="addNewRow"
           value="Ny rad" />
  </div>
</div>
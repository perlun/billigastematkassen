<div class="navbar navbar-fixed-top">
  <div class="navbar-inner">
    <div class="container">
      <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </a>
      <a class="brand" href="#/">Billigaste Matkassen</a>

      <div class="nav-collapse">
        <ul class="nav">
          <% _.each(dataContext.globalData.productGroups, function(group) { %>
          <li><a href="#/produkter/<%= group.slug %>"><%= group.name %></a></li>
          <% }); %>
        </ul>
      </div>
    </div>
  </div>
</div>
<div class="container">
  <div class="row">
    <!-- Placeholder that just consumes space, which is used by the "real" sidebar -->
    <div class="span2">
    </div>
    <!-- "Real" sidebar -->
    <div style="position: fixed;">
      <ul class="nav nav-list">
        <li class="nav-header">Innehåll</li>
        <li>
          <a href="#/produkter">Priser</a>
        </li>
        <li>
          <a href="#/redigera">Redigera</a>
        </li>
        <li>
          <a href="#/varukorg">Varukorg</a>
          <span id="itemCountContainer" style="display: none;">(<span id="itemCount">0</span> artiklar)</span>
        </li>
      </ul>
    </div>
    <div class="span10">
      <div id="content" style="min-height: 300px;"/>
    </div>
  </div>
  <hr/>
  <footer id="footer">
    <div>
      <small>
        :: <span>Klient: <a href="http://twitter.github.com/bootstrap/">Twitter Bootstrap</a> | <a href="http://bootswatch.com/simplex/">Simplex</a> | <a href="http://www.coffeescript">CoffeeScript</a> | <a href="http://www.dhtmlx.com">dhtmlxGrid</a></span> ::
        <span>Server: <a href="http://www.sinatrarb.com">Sinatra</a> | <a href="http://www.jruby.org">JRuby</a> | <a href="http://www.redis.io">Redis</a></span> ::
      </small>
    </div>
  </footer>
</div><!-- /#container -->
  <div style="margin-bottom: 12px;">
    <button class="btn" {{action saveRows}}>Spara</button>
  </div>

  <table class="table table-striped table-hover table-condensed">
    <thead>
      <tr>
        <th>Artikel</th>
        <th>Vikt/volym</th>
        <th>Enhet</th>
        <th>Varumärke</th>
        <th>Tillverkare</th>
        <th>Produktgrupp</th>
        <th>Axet</th>
        <th>Citymarket</th>
        <th>Lidl</th>
        <th>Minimani</th>
        <th>Prisma</th>
      </tr>
    </thead>
    <tbody id="productRows">
      <tr data-each-item="items">
        <td><input data-value="item.name" type="text" class="editName"/></td>
        <td><input type="text" data-value="item.qty" class="editQty"/></td>
        <td><input type="text" data-provide="typeahed" autocomplete="off" class="editQty"/></td>
          <!--select data-value="item.unitOfMeasure" class="editQty">
            <option value=""></option>
            <option data-each-um="unitOfMeasures" data-text="um" data-value="um"/>
          </select-->
        </td>
        <td><input type="text" data-value="item.brand" class="editBrand"/></td>
        <td><input type="text" data-value="item.manufacturer" class="editBrand"/></td>
        <td><!--{{view Ember.Select contentBinding="globalData.productGroups"
                                prompt=" "
                                optionValuePath="content.description"
                                optionLabelPath="content.description"
                                valueBinding="item.productGroup"
                                classNames="editProductGroup"}}--></td>
        <td><input type="text" data-value="item.price_axet" class="editMoney"/></td>
        <td><input type="text" data-value="item.price_citymarket" class="editMoney"/></td>
        <td><input type="text" data-value="item.price_lidl" class="editMoney"/></td>
        <td><input type="text" data-value="item.price_minimani"  class="editMoney"/></td>
        <td><input type="text" data-value="item.price_prisma" class="editMoney"/></td>        
        <td><a href="#" data-command="deleteRow"><i class="icon-trash"></i></a></td>
      </tr>
    </tbody>
  </table>

  <div>
    <button class="btn" data-command="addNewRow">Lägg till ny rad</button>
  </div>
  <div style="margin-top: 12px;">
    <button class="btn" {{action saveRows}}>Spara</button>
  </div>

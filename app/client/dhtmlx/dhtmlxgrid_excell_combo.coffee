# Based on http://trac.reddes.bvsalud.org/projects/abcd/browser/tags/0.3-beta-linux/htdocs/php/dataentry/js/dhtml_grid/dhtmlXGrid_excell_combo.js?rev=78
#
# Original copyright:
#   dhtmlxGrid v.1.4 build 70813 Standard Edition
#   Copyright Scand LLC http://www.scbr.com
#   This version of Software is free for using in GPL applications. For commercial use please contact info@scbr.com to obtain license
window.eXcell_combo = (cell) ->
  try
    @cell = cell
    @grid = @cell.parentNode.grid

  @edit = ->
    editValue = @getValue()
    values = @grid.collectValues(@cell.cellIndex)
    @cell.innerHTML = ''

    @obj = new dhtmlXCombo(@cell, 'combo', @cell.offsetWidth - 2)
    @obj.enableFilteringMode(true)
    @obj.DOMelem.style.border = '0'
    @obj.DOMelem.style.height = '18px'
    
    for i in [0..values.length - 1]
      value = values[i]
      #continue if value.indexOf('<div') != -1

      @obj.addOption(i - 0, value)

    @obj.setComboText(editValue)
    @obj.DOMelem_input.focus()

  @getValue = (val) ->
    @cell.innerHTML.toString()

  @setValue = (val) ->
    if typeof (val) is 'object'
      switch val.type
        when 1
          @cell.loadingMode = '1'
          @cell._url = val.url
        else
          @cell.loadingMode = '0'
          @cell._url = val.url
      val = val.value or ''
    @setCValue val

  @detach = ->
    if not @obj.getComboText() or @obj.getComboText().toString()._dhx_trim() is ''
      @setCValue ''
    else
      @setCValue @obj.getComboText(), @obj.getActualValue()
    @cell._cval = @obj.getActualValue()
    @obj.closeAll()
    true

  @

window.eXcell_combo:: = new window.eXcell()

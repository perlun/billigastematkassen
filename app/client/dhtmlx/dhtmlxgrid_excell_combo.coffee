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
    @oldValue = @getValue()
    values = @grid.collectValues(@cell.cellIndex)
    @cell.innerHTML = ''

    @obj = new dhtmlXCombo(@cell, 'combo', @cell.offsetWidth - 2)
    @obj.enableFilteringMode(true)
    @obj.DOMelem.style.border = '0'
    @obj.DOMelem.style.height = '18px'
    
    @obj.DOMelem.onkeydown = (e) =>
      if (e.keyCode < 30)
        return @grid.doKey(
          target: @cell
          keyCode: e.keyCode,
          shiftKey: e.shiftKey,
          ctrlKey: e.ctrlKey
        )

    for i in [0..values.length - 1]
      value = values[i]
      continue unless value?.length
      @obj.addOption(value, value)

    @obj.setComboText(@oldValue)
    @obj.DOMelem_input.focus()

  @getValue = (val) ->
    @cell.textContent.trim()

  @setValue = (val) ->
    @setCValue(val or '')

  #
  # @desc: return value to cell, closes editor
  # @returns: if cell's value was changed (true) or not
  # @type: private
  #
  @detach = ->
    if not @obj.getComboText() or @obj.getComboText().toString()._dhx_trim() is ''
      @setCValue ''
    else
      @setCValue @obj.getComboText()

    @obj.closeAll()

    @oldValue != @obj.getActualValue()

  @

window.eXcell_combo:: = new window.eXcell()

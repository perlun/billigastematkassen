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
    val = @getValue()
    @cell.innerHTML = ""
    @obj = new dhtmlXCombo(@cell, "combo", @cell.offsetWidth - 2)
    @obj.DOMelem.style.border = "0"
    @obj.DOMelem.style.height = "18px"
    
    # loadingMode == null
    switch @cell.loadingMode
      when "0"
        selfc = this
        @obj.loadXML @cell._url, ->
          selfc.obj.setComboValue val

      when "1"
        @obj.enableFilteringMode true, @cell._url, true, true

      when "2"
        i = 0

        while i < options.length
          @obj.addOption i, options[i].firstChild.data
          i++
    @obj.setComboText ""  if @cell.loadingMode is "0"

  @getValue = (val) ->
    @cell.innerHTML.toString()

  @setValue = (val) ->
    if typeof (val) is "object"
      unless val.tagName
        switch val.type
          when 1
            @cell.loadingMode = "1"
            @cell._url = val.url
          else
            @cell.loadingMode = "0"
            @cell._url = val.url
        val = val.value or ""
      else
        @cell.loadingMode = val.getAttribute("xmlcontent")
        if @cell.loadingMode is "2"
          options = @grid.xmlLoader.doXPath(".//option", val)
          val = options[0].firstChild.data
        else
          childNumber = val.childNodes.length
          i = 0

          while i < childNumber
            @cell._url = val.childNodes[i].childNodes[0].data  if val.childNodes[i].tagName is "url"
            i++
          i = 0

          while i < childNumber
            val = val.childNodes[i].childNodes[0].data  if (typeof (val) is "object") and (val.childNodes[i].tagName is "value")
            i++
    @setCValue val

  @detach = ->
    if not @obj.getComboText() or @obj.getComboText().toString()._dhx_trim() is ""
      @setCValue ""
    else
      @setCValue @obj.getComboText(), @obj.getActualValue()
    @cell._cval = @obj.getActualValue()
    @obj.closeAll()
    true

  @

window.eXcell_combo:: = new window.eXcell()

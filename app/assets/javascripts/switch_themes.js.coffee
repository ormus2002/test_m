jQuery ->
  setCookie = (key, value) ->
    expires = new Date()
    expires.setTime expires.getTime() + (1 * 24 * 60 * 60 * 1000)
    document.cookie = key + "=" + value + ";expires=" + expires.toUTCString()
  getCookie = (key) ->
    keyValue = document.cookie.match("(^|;) ?" + key + "=([^;]*)(;|$)")
    (if keyValue then keyValue[2] else null)
  $(".swatch").click ->
    name_swatch = $(this).attr("name")
    $(".switch[rel*='stylesheet']").attr "href", "/styles/bootstrap.min_"+name_swatch+".css?body=1"
    setCookie("primer_sheetswitch_name", name_swatch)
  if getCookie("primer_sheetswitch_name")
    name_swatch = getCookie("primer_sheetswitch_name")
    $(".switch[rel*='stylesheet']").attr "href", "/styles/bootstrap.min_"+name_swatch+".css?body=1"
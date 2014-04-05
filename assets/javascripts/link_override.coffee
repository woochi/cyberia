$(document).on "click", "a:not([data-bypass])", (evt) ->
  href =
    prop: $(this).prop("href")
    attr: $(this).attr("href")
  root = location.protocol + "//" + location.host + Backbone.history.options.root
  if href.prop and href.prop.slice(0, root.length) is root
    evt.preventDefault()
    Backbone.history.navigate href.attr, true
  return

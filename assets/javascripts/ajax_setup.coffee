getCookie = (name) ->
  cookieValue = null
  if document.cookie and document.cookie isnt ""
    cookies = document.cookie.split(";")
    i = 0

    while i < cookies.length
      cookie = jQuery.trim(cookies[i])
      
      # Does this cookie string begin with the name we want?
      if cookie.substring(0, name.length + 1) is (name + "=")
        cookieValue = decodeURIComponent(cookie.substring(name.length + 1))
        break
      i++
  cookieValue

csrfSafeMethod = (method) ->
  /^(GET|HEAD|OPTIONS|TRACE)$/.test method

sameOrigin = (url) ->
  host = document.location.host # host + port
  protocol = document.location.protocol
  sr_origin = "//" + host
  origin = protocol + sr_origin
  (url is origin or url.slice(0, origin.length + 1) is origin + "/") or (url is sr_origin or url.slice(0, sr_origin.length + 1) is sr_origin + "/") or not (/^(\/\/|http:|https:).*/.test(url))

csrftoken = getCookie("csrftoken")

$.ajaxSetup beforeSend: (xhr, settings) ->
  # Send the token to same-origin, relative URLs only.
  # Send the token only if the method warrants CSRF protection
  # Using the CSRFToken value acquired earlier
  if not csrfSafeMethod(settings.type) and sameOrigin(settings.url)
    xhr.setRequestHeader "X-CSRFToken", csrftoken

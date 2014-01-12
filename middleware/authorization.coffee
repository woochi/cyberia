exports.requiresLogin = (req, res, next) ->
  return next() if req.isAuthenticated()
  req.session.returnTo = req.originalUrl if req.method is "GET"
  res.redirect "/login"

exports.user = hasAuthorization: (req, res, next) ->
  unless req.profile.id is req.user.id
    req.flash "info", "You are not authorized"
    return res.redirect("/users/" + req.profile.id)
  next()

exports.article = hasAuthorization: (req, res, next) ->
  unless req.article.user.id is req.user.id
    req.flash "info", "You are not authorized"
    return res.redirect("/articles/" + req.article.id)
  next()

exports.comment = hasAuthorization: (req, res, next) ->
  
  # if the current user is comment owner or article owner
  # give them authority to delete
  if req.user.id is req.comment.user.id or req.user.id is req.article.user.id
    next()
  else
    req.flash "info", "You are not authorized"
    res.redirect "/articles/" + req.article.id

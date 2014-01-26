exports.requiresLogin = (req, res, next) ->
  return next() if req.isAuthenticated()
  req.session.returnTo = req.originalUrl if req.method is "GET"
  res.redirect "/login"

exports.redirectLoggedIn = (req, res, next) ->
  return next() unless req.user
  res.redirect "/app"

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

exports.post =
  canRead: (req, res, next) ->
  canCreate: (req, res, next) ->
  canDelete: (req, res, next) ->

exports.message =
  canRead: (req, res, next) ->
  canCreate: (req, res, next) ->

exports.event =
  canRead: (req, res, next) ->
  canCreate: (req, res, next) ->

exports.article =
  canRead: (req, res, next) ->
  canCreate: (req, res, next) ->

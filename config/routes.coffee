async = require("async")
auth = require('../middleware/authorization')

site = require("../controllers/site")
users = require("../controllers/users")

###
Route middlewares
###
#articleAuth = [auth.requiresLogin, auth.article.hasAuthorization]
#commentAuth = [auth.requiresLogin, auth.comment.hasAuthorization]

###
Expose routes
###
module.exports = (app, passport) ->

  # Static pages
  app.get "/", auth.redirectLoggedIn, site.index
  app.get "/app", auth.requiresLogin, site.app
  app.get "/app*", auth.requiresLogin, site.app

  # Sessions
  app.get '/login', auth.redirectLoggedIn, users.login
  app.get '/logout', users.logout
  app.post '/login', passport.authenticate('local',
    successRedirect: '/app'
    failureRedirect: '/login')

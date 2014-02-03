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
  #app.get "/app", auth.requiresLogin, site.app
  #app.get "/app*", auth.requiresLogin, site.app

  app.get "/info/general", auth.requiresLogin, site.general
  app.get "/info/world", auth.requiresLogin, site.world
  app.get "/info/timeline", auth.requiresLogin, site.timeline
  app.get "/info/character", auth.requiresLogin, site.character

  # Sessions
  app.get '/login', auth.redirectLoggedIn, users.login
  app.get '/logout', users.logout
  app.post '/login', passport.authenticate('local',
    successRedirect: '/info/general'
    failureRedirect: '/login'), users.session

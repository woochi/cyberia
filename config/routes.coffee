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
  app.get "/", site.index
  app.get "/app", auth.requiresLogin, site.app
  #app.get "/timeline", site.timeline

  # Sessions
  app.get '/login', users.login
  app.get '/logout', users.logout
  app.post '/login', passport.authenticate('local',
    successRedirect: '/app'
    failureRedirect: '/login'), users.session

  # Users
  #app.post "/users", users.create
  #app.get "/users", users.list
  #app.get "/users/:id", users.show
  #app.put "/users/:id", users.update

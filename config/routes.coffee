site = require("../controllers/site")

module.exports = (app, passport) ->

  # Static pages
  app.get "/", site.index
  app.get "/*", (req, res, next) ->
    res.redirect "/"

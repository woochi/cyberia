###
Module dependencies.
###
express = require("express")
flash = require("connect-flash")
winston = require("winston")
helpers = require("view-helpers")
pkg = require("../package.json")
path = require("path")
env = process.env.NODE_ENV or "development"

module.exports = (app, config) ->
  #app.set "showStackError", true

  # Static assets
  app.use express.static(path.join(config.root, "assets", "images"))
  app.use express.static(path.join(config.root, "assets", "videos"))
  app.use "/stylesheets", express.static(config.root + "/build/assets/stylesheets")
  app.use "/javascripts", express.static(config.root + "/build/assets/javascripts")

  # Favicon
  app.use express.favicon(path.join(config.root, "assets", "images", "favicon_256.png"))

  # Logging
  # Use winston on production
  log = undefined
  if env isnt "development"
    log = stream:
      write: (message, encoding) ->
        winston.info message
  else
    log = "dev"

  # Don't log during tests
  app.use express.logger(log) if env isnt "test"
  
  # set views path, template engine and default layout
  app.set "views", config.root + "/views"
  app.set "view engine", "jade"

  app.configure ->    
    # cookieParser should be above session
    app.use express.cookieParser()
    
    # bodyParser should be above methodOverride
    app.use express.json()
    app.use express.urlencoded()
    app.use express.methodOverride()
    app.use express.errorHandler() if env is "development"
    
    # connect flash for flash messages - should be declared after sessions
    app.use flash()

    # routes should be at the last
    app.use app.router

###
Module dependencies.
###
express = require("express")
mongoStore = require("connect-mongo")(express)
flash = require("connect-flash")
winston = require("winston")
helpers = require("view-helpers")
pkg = require("../package.json")
path = require("path")
env = process.env.NODE_ENV or "development"

module.exports = (app, config, passport) ->
  #app.set "showStackError", true

  # Static assets
  app.use express.static(path.join(config.root, "assets", "images"))
  app.use express.static(path.join(config.root, "assets", "videos"))
  app.use "/stylesheets", express.static(config.root + "/build/assets/stylesheets")
  app.use "/javascripts", express.static(config.root + "/build/assets/javascripts")

  # Favicon
  app.use express.favicon(path.join(config.root, "assets", "images", "favicon.ico"))

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
    app.use express.bodyParser()
    app.use express.methodOverride()
    app.use express.errorHandler() if env is "development"
    
    # express/mongo session storage
    app.use express.session(
      secret: pkg.name
      store: new mongoStore(
        url: config.db
        collection: "sessions"
      )
    )
    
    # use passport session
    app.use passport.initialize()
    app.use passport.session()
    
    # connect flash for flash messages - should be declared after sessions
    app.use flash()
    
    # should be declared after session and flash
    #app.use helpers(pkg.name)
    
    # adds CSRF support
    app.use express.csrf()
    app.use require('connect-csrf-cookie')()

    # This could be moved to view-helpers :-)
    app.use (req, res, next) ->
      res.locals.csrf_token = req.csrfToken()
      next()

    
    # routes should be at the last
    app.use app.router
    
    # assume "not found" in the error msgs
    # is a 404. this is somewhat silly, but
    # valid, you can do whatever you like, set
    # properties, use instanceof etc.
    ###
    app.use (err, req, res, next) ->
      
      # treat as 404
      return next()  if err.message and (~err.message.indexOf("not found") or (~err.message.indexOf("Cast to ObjectId failed")))
      
      # log it
      # send emails if you want
      console.error err.stack
      
      # error page
      res.status(500).render "500",
        error: err.stack

    # assume 404 since no middleware responded
    app.use (req, res, next) ->
      res.status(404).render "404",
        url: req.originalUrl
        error: "Not found"
    ###

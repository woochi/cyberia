
###
Module dependencies.
###
express = require("express")
mongoStore = require("connect-mongo")(express)
http = require("http")
fs = require('fs')
path = require("path")
mongoose = require("mongoose")
passport = require("passport")
app = express()
server = http.createServer(app)

env = process.env.NODE_ENV or "development"
config = require("./config/config")[env]

# Bootstrap db connection
# Connect to mongodb
connect = ->
  options =
    server:
      socketOptions:
        keepAlive: 1
  mongoose.connect config.db, options

connect()

# Error handler
mongoose.connection.on "error", (err) ->
  console.log err

# Reconnect when closed
mongoose.connection.on "disconnected", ->
  connect()

models_path = __dirname + "/models"
fs.readdirSync(models_path).forEach (file) ->
  require(models_path + "/" + file)  if ~file.indexOf(".coffee")

sessionStore = new mongoStore(
  url: config.db
  collection: "sessions"
  auto_reconnect: true
)

# Configuration
require('./config/passport')(passport, config)
require('./config/express')(app, config, passport, sessionStore)
require('./config/routes')(app, passport)
require('./config/sockets')(server, passport, sessionStore, config)

port = process.env.PORT || config.port
app.set "port", port

server.listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")


###
Module dependencies.
###

express = require("express")
http = require("http")
fs = require('fs')
path = require("path")
app = express()
server = http.createServer(app)

env = process.env.NODE_ENV or "development"
config = require("./config/config")[env]

require('./config/express')(app, config)
require('./config/routes')(app)

port = process.env.PORT || config.port
app.set "port", port

server.listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")


###
Module dependencies.
###
express = require("express")
routes = require("./routes")
user = require("./routes/user")
http = require("http")
path = require("path")
app = express()

# all environments
app.set "port", process.env.PORT or 3000
app.set "views", __dirname + "/views"
app.set "view engine", "jade"
app.use express.favicon()
app.use express.logger("dev")
app.use express.bodyParser()
app.use express.methodOverride()
app.use app.router
app.use express.static(path.join(__dirname, "public"))
app.use "/stylesheets", express.static(__dirname + "/build/stylesheets")
app.use "/javascripts", express.static(__dirname + "/build/javascripts")

serveAsset = (req, res, next) ->
  res.sendfile path.join(__dirname, "build", "assets", req.url)

app.use express.errorHandler()  if "development" is app.get("env")
app.get "/javascripts/*", serveAsset
app.get "/stylesheets/*", serveAsset
app.get "/", routes.index
app.get "/*", routes.index
  
http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")

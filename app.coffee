
###
Module dependencies.
###
express = require("express")
routes = require("./routes")
user = require("./routes/user")
http = require("http")
https = require("https")
path = require("path")
app = express()
fs = require("fs")

# all environments
app.set "port", process.env.PORT or 3000
app.set "views", __dirname + "/views"
app.set "view engine", "jade"
app.use express.favicon(path.join(__dirname, "assets", "images", "favicon.ico"))
app.use express.logger("dev")
app.use express.bodyParser()
app.use express.methodOverride()
app.use app.router
app.use express.static(path.join(__dirname, "assets", "images"))
app.use express.static(path.join(__dirname, "assets", "videos"))
app.use "/stylesheets", express.static(__dirname + "/build/stylesheets")
app.use "/javascripts", express.static(__dirname + "/build/javascripts")

serveAsset = (req, res, next) ->
  res.sendfile path.join(__dirname, "build", "assets", req.url)

app.use express.errorHandler()  if "development" is app.get("env")
app.get "/javascripts/*", serveAsset
app.get "/stylesheets/*", serveAsset
app.get "/", routes.index

if app.get("env") is "production"
  options =
    key: fs.readFileSync('/etc/haproxy/certs/cyberia2020-key.pem')
    cert: fs.readFileSync('/etc/haproxy/certs/cyberia2020-cert.pem')
    ca: fs.readFileSync('/etc/haproxy/certs/cyberia2020-intermediate.pem')

  https.createServer(options, app).listen app.get("port"), ->
    console.log "Express server listening on port " + app.get("port")

else
  http.createServer(app).listen app.get("port"), ->
    console.log "Express server listening on port " + app.get("port")

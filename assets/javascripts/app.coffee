require("./ajax_setup.coffee")
Backbone = require("backbone")
Marionette = require("marionette")
AppRouter = require("./routers/app.coffee")
User = require("./models/user.coffee")

$ ->
  window.App = new Marionette.Application()
  App.addInitializer (options) ->
    @user = new User(window.user)
    delete window.user
    $("#bootstrap").remove()
  App.addInitializer (options) ->
    @appRouter = new AppRouter()
    $("#loader").remove()
    Backbone.history.start
      pushState: true
      root: "/app"
  ###
  App.addRegions
    toolbar: "#toolbar"
    content: "#content"
  ###
  App.start()

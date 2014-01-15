require("./ajax_setup.coffee")
Backbone = require("backbone")
require("backbone.io")
Marionette = require("marionette")
AppRouter = require("./routers/app.coffee")
PostsRouter = require("./routers/posts.coffee")
UsersRouter = require("./routers/users.coffee")
HackingRouter = require("./routers/hacking.coffee")
MessagesRouter = require("./routers/messages.coffee")
User = require("./models/user.coffee")
Users = require("./collections/users.coffee")
Posts = require("./collections/posts.coffee")
Navigation = require("./views/sidebar/navigation.coffee")

$ ->
  window.App = new Marionette.Application()
  App.addInitializer (options) ->
    @user = new User(window.user)
    @users = new Users(window.users)
    posts = new Posts()
    posts.create {author: @user, text: "Whadap y'all"}
    setTimeout ->
      posts.fetch
        success: (data, a) -> console.log data, a
    , 2000
    delete window.user
    $("#bootstrap").remove()
  App.addInitializer (options) ->
    @appRouter = new AppRouter()
    @postsRouter = new PostsRouter()
    @usersRouter = new UsersRouter()
    @hackingRouter = new HackingRouter()
    @messagesRouter = new MessagesRouter()
    $("#loader").remove()
    Backbone.history.start
      pushState: true
      root: "/app"
  App.addInitializer (options) ->
    @sidebar.show new Navigation(model: @user)
  App.addRegions
    content: "#content"
    sidebar: "#sidebar"
    additional: "#additional"
  App.socket = Backbone.io.connect()
  App.socket.on "connect", ->
    console.log "connected to the socket"
    App.start()

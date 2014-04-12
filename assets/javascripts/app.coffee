require("./ajax_setup.coffee")
Backbone = require("backbone")
require("backbone.io")
Marionette = require("marionette")
AppRouter = require("./routers/app.coffee")
PostsRouter = require("./routers/posts.coffee")
DataRouter = require("./routers/data.coffee")
UsersRouter = require("./routers/users.coffee")
HackingRouter = require("./routers/hacking.coffee")
MessagesRouter = require("./routers/messages.coffee")
AdminRouter = require("./routers/admin.coffee")
User = require("./models/user.coffee")
Users = require("./collections/users.coffee")
Posts = require("./collections/posts.coffee")
Messages = require("./collections/messages.coffee")
Unreads = require("./collections/unreads.coffee")
Navigation = require("./views/sidebar/navigation.coffee")
NavigationMobile = require("./views/sidebar/navigation_mobile.coffee")

$ ->
  window.App = new Marionette.Application()
  App.addInitializer (options) ->
    @user = new User(window.user)
    @users = new Users(window.users)
    @posts = new Posts(window.posts.reverse())
    @messages = new Messages(window.messages)
    @unreads = new Unreads(window.unreads, messages: @messages)
    delete window.user
    delete window.users
    delete window.posts
    delete window.unreads
    $("#bootstrap").remove()
    @user.on "backend:update", (model) =>
      if model.id is @user.id and model.get("disabled")
        alert "Yhteytesi on lukittu! Sinut kirjataan ulos. Ota yhteys pelinjohtoon."
        setTimeout ->
          window.location = "/logout"
        , 5000

  App.addInitializer (options) ->
    User = require("./models/user.coffee")
    Users = require("./collections/users.coffee")
    UserList = require("./views/users/list.coffee")
    @sidebar.show new Navigation(model: @user)
    @additional.show new UserList(collection: @users, unreads: @unreads)
  App.addRegions
    content: "#content"
    sidebar: "#sidebar"
    additional: "#additional"
  App.addInitializer (options) ->
    @appRouter = new AppRouter()
    @postsRouter = new PostsRouter()
    @dataRouter = new DataRouter()
    @usersRouter = new UsersRouter()
    @hackingRouter = new HackingRouter()
    @messagesRouter = new MessagesRouter()
    @adminRouter = new AdminRouter() if !@user.admin
    $("#loader").remove()

    Backbone.history.start
      pushState: true
      root: "/app"
    fragments = Backbone.history.fragment.split("/")
    if fragments[0] is "messages"
      @additional.currentView.toggleCurrent @users.get(fragments[1])
    else
      @sidebar.currentView.toggleCurrent fragments[0]
  new NavigationMobile(el: $("#mobile-nav"))
  origin = window.location.origin
  options = if origin.indexOf("https") > -1 then secure: true else undefined
  App.socket = Backbone.io.connect(window.location.origin, options)
  App.socket.on "connect", ->
    App.start()

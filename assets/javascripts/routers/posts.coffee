Marionette = require("marionette")
PostsController = require("../controllers/posts.coffee")

class PostsRouter extends Marionette.AppRouter
  controller: new PostsController()
  appRoutes:
    "posts": "index"
    "posts/new": "new"

module.exports = PostsRouter

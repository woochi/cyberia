Post = require("../models/post.coffee")

class PostsController

  index: ->
    PostsList = require("../views/posts/list.coffee")
    App.content.show new PostsList(collection: App.posts)
    App.appRouter.navigate "posts"

  new: ->
    @index()
    PostForm = require("../views/posts/form.coffee")
    form = new PostForm(model: new Post()).open()
    form.on "close", -> App.appRouter.navigate "posts"
    App.appRouter.navigate "posts/new"

module.exports = PostsController

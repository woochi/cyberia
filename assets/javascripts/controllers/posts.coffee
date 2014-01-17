class PostsController

  index: ->
    Post = require("../models/post.coffee")
    Posts = require("../collections/posts.coffee")
    PostsList = require("../views/posts/list.coffee")
    posts = new Posts()
    App.content.show new PostsList(collection: posts)
    App.appRouter.navigate "posts"
    posts.fetch()

module.exports = PostsController

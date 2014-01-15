class PostsController

  index: ->
    Post = require("../models/post.coffee")
    Posts = require("../collections/posts.coffee")
    PostsList = require("../views/posts/list.coffee")
    Attachment = require("../models/attachment.coffee")
    posts = new Posts((new Post() for i in [0..5]))
    posts.at(1).set("attachment", new Attachment())
    App.content.show new PostsList(collection: posts)
    App.appRouter.navigate "posts"
    setTimeout ->
      posts.add new Post()
    , 2000

module.exports = PostsController

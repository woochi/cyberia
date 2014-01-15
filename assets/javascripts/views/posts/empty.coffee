Marionette = require("marionette")

class PostsEmptyView extends Marionette.ItemView
  template: require("../../templates/posts/empty.jade")

module.exports = PostsEmptyView

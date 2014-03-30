async = require("async")
mongoose = require("mongoose")
User = mongoose.model("User")
Post = mongoose.model("Post")

exports.index = (req, res) ->
  res.render "index"

exports.timeline = (req, res) ->
  res.render "timeline"

exports.app = (req, res) ->
  async.parallel
    users: (callback) -> User.find {_id: {$ne: req.user._id}}, callback
    posts: (callback) ->
      Post.find({})
        .sort(sent: -1)
        .limit(10)
        .populate("author")
        .exec callback
  , (err, result) ->
    res.render "app",
      user:
        _id: req.user._id
        name: req.user.name
        username: req.user.username
        status: req.user.status
        admin: req.user.admin
        group: req.user.group
      users: result.users
      posts: result.posts

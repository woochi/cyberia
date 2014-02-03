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
    posts: (callback) -> Post.find({})
      .sort(sent: -1)
      .limit(10)
      .populate("author")
      .exec callback
  , (err, result) ->
    res.render "app",
      user: {_id: req.user._id, name: req.user.name, status: req.user.status}
      users: result.users
      posts: result.posts

exports.general = (req, res) ->
  res.render "general"

exports.world = (req, res) ->
  res.render "world"

exports.timeline = (req, res) ->
  res.render "timeline"

exports.character = (req, res, next) ->
  User.findById req.user._id, (err, user) ->
    return next(err) if err
    res.render "character", character: user

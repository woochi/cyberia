async = require("async")
mongoose = require("mongoose")
ObjectId = mongoose.Types.ObjectId
User = mongoose.model("User")
Post = mongoose.model("Post")
Message = mongoose.model("Message")

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
    messages: (callback) ->
      opts =
        query:
          to: req.user._id
          unread: true
        map: -> emit(@from, 1)
        reduce: (key, vals) -> vals.length
        limit: 50
      Message.mapReduce opts, callback
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
      unreads: result.messages[0]

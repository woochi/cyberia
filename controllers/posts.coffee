mongoose = require("mongoose")
Post = mongoose.model("Post")

exports.read = (req, res, next) ->
  if req.model.id
    Post.findById req.model.id, (err, post) ->
      return next(err) if err
      return next(new Error("Post could not be found.")) if !post
      res.end talent
  else
    Post.find {}, (err, posts) ->
      return next(err) if err
      return next(new Error("Posts could not be fetched.")) if !posts
      res.end posts

exports.create = (req, res, next) ->
  console.log req.model
  # TODO

exports.delete = (req, res, next) ->
  console.log req.model
  # TODO

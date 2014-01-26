mongoose = require("mongoose")
Post = mongoose.model("Post")

exports.read = (req, res, next) ->
  if req.model.id
    Post.findById(req.model.id)
      .populate("author")
      .exec (err, post) ->
        return next(err) if err
        return next(new Error("Post could not be found.")) if !post
        res.end post
  else
    Post.find({})
      .sort(sent: -1).limit(10)
      .populate("author")
      .exec (err, posts) ->
        return next(err) if err
        return next(new Error("Posts could not be fetched.")) if !posts
        res.end posts

exports.create = (req, res, next) ->
  post = new Post
    author: req.model.author._id
    text: req.model.text
  post.save (err, model) ->
    return next(err) if err
    Post.populate model, {path: "author"}, (err, model) ->
      return next(err) if err
      res.end model

exports.delete = (req, res, next) ->
  console.log req.model
  # TODO

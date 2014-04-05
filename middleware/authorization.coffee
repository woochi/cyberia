mongoose = require("mongoose")
Post = mongoose.model("Post")
Message = mongoose.model("Message")
ObjectId = mongoose.Types.ObjectId

exports.requiresLogin = (req, res, next) ->
  return next() if req.isAuthenticated()
  res.redirect "/login"

exports.redirectLoggedIn = (req, res, next) ->
  return next() unless req.user
  res.redirect "/app"

exports.user =
  canRead: (req, res, next) -> next()
  canUpdate: (req, res, next) ->
    isOwner = req.user._id.equals(new ObjectId req.model._id)
    if not req.user.admin and not isOwner
      return next(new Error("Unauthorized."))
    next()

exports.post =
  canRead: (req, res, next) -> next()
  canCreate: (req, res, next) -> next()
  canDelete: (req, res, next) ->
    if req.model.id and not req.user.admin
      Post.findById req.model.id, (err, post) ->
        return next(err) if err
        return next(new Error("Post could not be found.")) unless post
        if post.author._id isnt req.user._id
          return next(new Error("You're not permitted to delete this post."))
    next()

exports.message =
  canRead: (req, res, next) ->
    if req.model.id and not req.user.admin
      Message.findById req.model.id, (err, message) ->
        return next(err) if err
        conversationParty = req.user._id.equals(new ObectId message.from) or req.user._id.equals(new ObjectId message.to)
        if not message or not conversationParty
          return next(new Error("Message could not be found."))
    next()

  canCreate: (req, res, next) -> next()

exports.event =
  canRead: (req, res, next) -> next()
  canCreate: (req, res, next) ->
    return next(new Error("Unauthorized.")) unless req.user.admin
    next()

exports.article =
  canRead: (req, res, next) -> next()
  canCreate: (req, res, next) -> next()

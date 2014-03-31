mongoose = require("mongoose")
Message = mongoose.model("Message")
User = mongoose.model("User")

exports.read = (req, res, next) ->
  if req.model.id
    Message.findById(req.model.id)
      .populate("author")
      .exec (err, message) ->
        return next(err) if err
        unless message
          return next(new Error("The message could not be found."))
        res.end message
  else
    if req.user.admin and not (req.options.from and req.options.to)
      return next(new Error("Must define 'from' and 'to' parameters."))
    if not req.options.to
      return next(new Error("Must define a 'to' parameter."))
    userId =
      if req.user.admin and req.options.from
      then req.options.from
      else req.user._id
    userId = userId + ""

    Message.find()
      .where("from").in([userId, req.options.from, req.options.to])
      .where("to").in([req.options.to, req.options.from, userId])
      .sort(sent: -1).limit(10)
      .populate("from to")
      .exec (err, messages) ->
        return next(err) if err
        unless messages
          return next(new Error("No messages could be found."))
        res.end messages.reverse()

exports.create = (req, res, next) ->
  message = new Message
    from: req.user._id
    to: req.model.to._id
    text: req.model.text

  message.save (err, message) ->
    return next(err) if err
    Message.populate message, {path: "from to"}, (err, message) ->
      return next(err) if err
      res.end message

exports.update = (req, res, next) ->
  console.log "UPDATE", req.model
  Message.findByIdAndUpdate req.model._id,
    unread: req.model.unread
  , (err, message) ->
    console.log "UPDATED", err, message
    return next(err) if err
    res.end message

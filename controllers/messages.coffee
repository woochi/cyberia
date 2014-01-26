mongoose = require("mongoose")
Message = mongoose.model("Message")

exports.read = (req, res, next) ->
  if req.model.id
    Message.findById(req.model.id)
      .populate("author")
      .exec (err, message) ->
        return next(err) if err
        return next(new Error("The message could not be found.")) unless message
        res.end message
  else
    unless req.options.from
      return next(new Error("Must define a from parameter."))
    Message.find()
      .where("from").in([req.options.from, req.options.to])
      .where("to").in([req.options.from, req.options.to])
      .sort(sent: -1).limit(10)
      .populate("from to")
      .exec (err, messages) ->
        return next(err) if err
        return next(new Error("No posts could be found.")) unless messages
        res.end messages.reverse()

exports.create = (req, res, next) ->
  message = new Message
    from: req.model.from._id
    to: req.model.to._id
    text: req.model.text
  message.save (err, message) ->
    return next(err) if err
    Message.populate message, {path: "from to"}, (err, message) ->
      return next(err) if err
      res.end message

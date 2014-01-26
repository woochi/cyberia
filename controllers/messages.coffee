mongoose = require("mongoose")
Message = mongoose.model("Message")
User = mongoose.model("User")

module.exports = (redisClient) ->

  read: (req, res, next) ->
    redisClient.get req.socket.id, (err, userId) ->
      return next(err) if err
      return next(new Error("User could not be found.")) unless userId
      User.findById userId, (err, user) ->
        return next(err) if err
        return next(new Error("User could not be found.")) unless user

        if req.model.id
          Message.findById(req.model.id)
            .populate("author")
            .exec (err, message) ->
              return next(err) if err
              unless message
                return next(new Error("The message could not be found."))
              res.end message
        else
          unless req.options.from
            return next(new Error("Must define a from parameter."))
          Message.find()
            .where("from").in([user._id, req.options.to])
            .where("to").in([req.options.from, user._id])
            .sort(sent: -1).limit(10)
            .populate("from to")
            .exec (err, messages) ->
              return next(err) if err
              unless messages
                return next(new Error("No messages could be found."))
              res.end messages.reverse()

  create: (req, res, next) ->
    redisClient.get req.socket.id, (err, userId) ->
      return next(err) if err
      return next(new Error("User could not be found.")) unless userId
      User.findById userId, (err, user) ->
        return next(err) if err
        return next(new Error("User could not be found.")) unless user
        message = new Message
          from: userId
          to: req.model.to._id
          text: req.model.text
        message.save (err, message) ->
          return next(err) if err
          Message.populate message, {path: "from to"}, (err, message) ->
            return next(err) if err
            res.end message

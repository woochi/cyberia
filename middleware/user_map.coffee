mongoose = require("mongoose")
User = mongoose.model("User")

module.exports = (redisClient) ->

  populate: (req, res, next) ->
    redisClient.get req.socket.id, (err, userId) ->
      return next(err) if err
      return next(new Error("User could not be found.")) unless userId
      User.findById userId, (err, user) ->
        return next(err) if err
        return next(new Error("User could not be found.")) unless user
        req.user = user
        next()

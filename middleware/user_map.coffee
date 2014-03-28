mongoose = require("mongoose")
User = mongoose.model("User")

module.exports = (server, io, redisClient) ->

  populate: (req, res, next) ->
    redisClient.get req.socket.id, (err, userId) ->
      return next(err) if err
      return next(new Error("User could not be found.")) unless userId
      User.findById userId, (err, user) ->
        return next(err) if err
        return next(new Error("User could not be found.")) unless user
        req.user = user
        next()

  mapReceiver: (req, res, next) ->
    console.log "Searching for", req.model.to._id
    redisClient.get req.model.to._id, (err, socketId) ->
      console.log "MESSAGE TO SOCKET:", socketId
      next(err) if err
      return next(new Error("User could not be found.")) unless socketId
      req.receiver = io.sockets.sockets[socketId]
      console.log "RECEIVER", req.receiver.id
      next()

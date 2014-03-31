mongoose = require("mongoose")
Code = mongoose.model("Code")

exports.read = (req, res, next) ->
  if req.model.key
    Code.find(key: req.model.key).exec (err, code) ->
        return next(err) if err
        return next(new Error("Post could not be found.")) if !code
        res.end code
  else
    Code.find({}).exec (err, codes) ->
        return next(err) if err
        return next(new Error("Posts could not be fetched.")) if !codes
        res.end code

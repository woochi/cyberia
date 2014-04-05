mongoose = require("mongoose")
Article = mongoose.model("Article")

exports.read = (req, res, next) ->
  if req.model.id
    Article.findById req.model.id, (err, article) ->
        return next(err) if err
        return next(new Error("The article could not be found.")) if !article
        res.end article
  else
    Article.find({}).select("title excerpt").exec (err, articles) ->
      return next(err) if err
      return next(new Error("Articles could not be fetched.")) if !articles
      res.end articles

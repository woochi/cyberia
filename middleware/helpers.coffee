url = require('url')

module.exports = (req, res, next) ->
  console.log req, res
  res.locals.isCurrent = (href) ->
    return req.url.indexOf(href) not -1
  next()

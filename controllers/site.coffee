
#
# * GET home page.
# 
exports.index = (req, res) ->
  res.render "index"

exports.timeline = (req, res) ->
  res.render "timeline"

exports.app = (req, res) ->
  res.render "app", user: {_id: req.user._id, name: req.user.name}

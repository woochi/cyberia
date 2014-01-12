###
Module dependencies.
###
mongoose = require("mongoose")
passport = require("passport")
User = mongoose.model("User")
utils = require("../lib/utils")

exports.login = (req, res) ->
  res.render "login"

exports.session = (req, res) ->
  redirectTo = (if req.session.returnTo then req.session.returnTo else "/")
  delete req.session.returnTo
  res.redirect redirectTo

exports.logout = (req, res) ->
  req.logout()
  res.redirect "/login"

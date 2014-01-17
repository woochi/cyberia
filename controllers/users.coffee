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

exports.read = (req, res, next) ->
  if req.model.id
    User.findById req.model.id, (err, user) ->
      return next(err) if err
      return next(new Error("The user could not be found.")) if !user
      res.end user
  else
    User.find {}, (err, users) ->
      return next(err) if err
      return next(new Error("Users could not be fetched.")) if !users
      res.end users

exports.update = (req, res, next) ->
  # TODO

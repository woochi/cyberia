mongoose = require('mongoose')
User = mongoose.model('User')
LocalStrategy = require('passport-local').Strategy

module.exports = (passport, config) ->

  # serialize sessions
  passport.serializeUser (user, done) ->
    done null, user.id

  passport.deserializeUser (id, done) ->
    User.findOne _id: id, "+hashed_password +salt", (err, user) ->
      done err, user
  
  # use local strategy
  passport.use new LocalStrategy(
    usernameField: "name"
    passwordField: "password"
  , (name, password, done) ->
    User.findOne name: name, "+hashed_password +salt", (err, user) ->
      return done(err) if err
      unless user
        return done(null, false, message: "Unknown user")
      unless user.authenticate(password)
        return done(null, false, message: "Invalid password")
      done null, user
  )

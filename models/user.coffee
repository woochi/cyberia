mongoose = require("mongoose")
validator = require('validator')
crypto = require('crypto')
Schema = mongoose.Schema

validatePresenceOf = (value) ->
  value && value.length

UserSchema = new Schema
  name: {type: String, required: true}
  username: {type: String, unique: true, required: true}
  hashed_password: {type: String, select: false, required: true}
  salt: {type: String, select: false, required: true}
  admin: {type: Boolean}
  status: {type: String}
  group: {type: String}
  online: {type: Boolean, default: false, required: true}
  disabled: {type: Boolean, default: false}

UserSchema.virtual("password").set((password) ->
  @_password = password
  @salt = @makeSalt()
  @hashed_password = @encryptPassword(password)
).get -> @_password

UserSchema.path("username").validate (name) ->
  validator.isAlphanumeric(name)
, "Invalid name"

UserSchema.path("hashed_password").validate (hashed_password) ->
  validator.isLength(hashed_password, 4)
, "Password is too short"

UserSchema.pre "save", (next) ->
  return next() unless this.isNew
  if !validatePresenceOf(this.password)
    return next(new Error("Invalid password"))
  next()

UserSchema.methods =

  authenticate: (plainText) ->
    @encryptPassword(plainText) is @hashed_password

  makeSalt: ->
    Math.round((new Date().valueOf() * Math.random())) + ""

  encryptPassword: (password) ->
    return "" unless password
    encrypred = undefined
    try
      encrypred = crypto.createHmac("sha1", @salt).update(password).digest("hex")
      return encrypred
    catch err
      return ""

mongoose.model "User", UserSchema

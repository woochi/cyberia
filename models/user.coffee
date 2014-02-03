mongoose = require("mongoose")
validator = require('validator')
crypto = require('crypto')
Schema = mongoose.Schema

validatePresenceOf = (value) ->
  value && value.length

CLASSES = ["Soolo", "Rokkari", "Dekkeri", "Media", "Pukumies", "Fixeri", "Kyttä", "Tekno", "Lekuri", "Kulkuri"]

GROUPS = ["Cyberia", "Asiakas", "Dreadnok", "Media", "Pukumies", "Archangel", "VIP", "NPC"]

IPSUM = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."

UserSchema = new Schema
  name: {type: String, default: "", unique: true, required: true}
  hashed_password: {type: String, default: "", select: false, required: true}
  salt: {type: String, default: "", select: false, required: true}
  admin: {type: Boolean, default: false, required: true}
  class: {type: String, enum: CLASSES, default: CLASSES[0], required: true}
  description: {type: String, default: IPSUM, required: true}
  status: {type: String, default: "", required: true}
  affiliation: {type: String, enum: GROUPS, default: GROUPS[0], required: true}
  online: {type: Boolean, default: false, required: true}

UserSchema.virtual("password").set((password) ->
  @_password = password
  @salt = @makeSalt()
  @hashed_password = @encryptPassword(password)
).get -> @_password

UserSchema.path("name").validate (name) ->
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

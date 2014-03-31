mongoose = require("mongoose")
validator = require('validator')
Schema = mongoose.Schema

MessageSchema = new Schema
  from: {type: Schema.ObjectId, ref: "User", required: true}
  to: {type: Schema.ObjectId, ref: "User", required: true}
  text: {type: String, required: true}
  sent: {type: Date, required: true, default: Date}
  unread: {type: Boolean, required: true, default: true}

mongoose.model "Message", MessageSchema

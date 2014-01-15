mongoose = require("mongoose")
validator = require('validator')
Schema = mongoose.Schema

MessageSchema = new Schema
  from: {type: Schema.ObjectId, ref: "User"}
  to: {type: Schema.ObjectId, ref: "User"}
  text: {type: String}
  sent: {type: Date, required: true, default: Date}

mongoose.model "Message", MessageSchema

mongoose = require("mongoose")
validator = require('validator')
Schema = mongoose.Schema

PostSchema = new Schema
  author: {type: Schema.ObjectId, ref: "User", required: true}
  text: {type: String, required: true}
  sent: {type: Date, required: true, default: Date.now}

mongoose.model "Post", PostSchema

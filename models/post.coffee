mongoose = require("mongoose")
validator = require('validator')
Schema = mongoose.Schema

PostSchema = new Schema
  author: {type: Schema.ObjectId, ref: "User"}
  text: {type: String}
  sent: {type: Date, required: true, default: Date}

mongoose.model "Post", PostSchema

mongoose = require("mongoose")
Schema = mongoose.Schema

CodeSchema = new Schema
  key: {type: String, required: true}
  difficulty: {type: String, required: true}
  value: {type: String, required: true}

mongoose.model "Code", CodeSchema

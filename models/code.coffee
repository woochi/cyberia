mongoose = require("mongoose")
Schema = mongoose.Schema

CodeSchema = new Schema
  key: {type: String, unique: true, index: true, required: true}
  difficulty: {type: Number, min: 0, max: 4, required: true}
  value: {type: String, required: true}

mongoose.model "Code", CodeSchema

mongoose = require("mongoose")
Schema = mongoose.Schema

difficulties = ["easy", "normal", "hard", "impossible"]

CodeSchema = new Schema
  key: {type: String, required: true}
  difficulty: {type: String, enum: difficulties, required: true}
  value: {type: String, required: true}

mongoose.model "Code", CodeSchema

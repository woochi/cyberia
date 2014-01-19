mongoose = require("mongoose")
Schema = mongoose.Schema

ArticleSchema = new Schema
  text: {type: String, default: "", required: true}
  publishedAt: {type: Date, default: Date.now, required: true}

mongoose.model "Article", ArticleSchema

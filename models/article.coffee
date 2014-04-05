mongoose = require("mongoose")
Schema = mongoose.Schema

ArticleSchema = new Schema
  title: {type: String, default: "", required: true}
  content: {type: String, default: "", required: true}
  excerpt: {type: String, default: "", required: true}
  date: {type: Date, default: Date.now, required: true}

mongoose.model "Article", ArticleSchema

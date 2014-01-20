mongoose = require("mongoose")
Schema = mongoose.Schema

ArticleSchema = new Schema
  title: {type: String, default: "", required: true}
  text: {type: String, default: "", required: true}
  keywords: {type: [String], default: [], required: true}
  publishedAt: {type: Date, default: Date.now, required: true}

mongoose.model "Article", ArticleSchema

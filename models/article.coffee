mongoose = require("mongoose")
Schema = mongoose.Schema

ARTICLE_TYPES = ["text", "audio", "video"]

ArticleSchema = new Schema
  type: {type: String, enum: ARTICLE_TYPES, required: true}
  title: {type: String, default: "", required: true}
  text: {type: String, default: "", required: true}
  keywords: {type: [String], default: [], required: true}
  published_at: {type: Date, default: Date.now, required: true}
  attachment_url: {type: String}

mongoose.model "Article", ArticleSchema

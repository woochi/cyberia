mongoose = require("mongoose")
path = require("path")
fs = require("fs")

# Load config
env = process.env.NODE_ENV || 'development'
config = require("../config/config")[env]

# Configure database
mongoose.connect config.db

# Bootstrap models
models_path = path.join(__dirname, "..", "models")
fs.readdirSync(models_path).forEach (file) ->
  require(path.join models_path, file)  if ~file.indexOf(".coffee")

unless process.argv[2]
  console.log "Usage: coffee migrate.coffee <migration>"
  process.exit(1)

migrationName = process.argv[2].split(":")[0]
migrationMethod = process.argv[2].split(":")[1] or "up"

# Load the migrations
migration = require(path.join(__dirname, "migrations", migrationName))
console.log "Running migration: #{migrationName}"

migration[migrationMethod] (err, models...) ->
  if err
    console.log err
    process.exit(1)
  console.log "Migration completed suffesfully"
  process.exit()

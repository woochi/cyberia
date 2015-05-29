fs = require("fs")

messages = require("./messages.json")
users = require("./users.json")

userMap = {}
populatedMessages = []

stringifyMessage = (message) ->
  "#{message.from} -> #{message.to}: #{message.text}\n\n"

for user in users
  userMap[user._id["$oid"]] =
    name: user.name

for message in messages
  populatedMessages.push
    from: userMap[message.from["$oid"]].name
    to: userMap[message.to["$oid"]].name
    text: message.text

stream = fs.createWriteStream("messages.txt")

stream.once "open", (fd) ->
  for message in populatedMessages
    stream.write stringifyMessage(message)
  stream.end()

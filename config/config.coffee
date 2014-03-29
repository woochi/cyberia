path = require("path")
rootPath = path.normalize(__dirname + "/..")

module.exports =
  development:
    port: 3000
    db: "mongodb://localhost/cyberia"
    root: rootPath
    app:
      name: "Cyberia"
    sessionKey: "cyberia.sid"
    sessionSecret: "v4R7ZbCs26AdNa1z8D3H"

  production:
    port: 8003
    db: "mongodb://localhost/cyberia"
    root: rootPath
    app:
      name: "Cyberia"
    sessionKey: "cyberia.sid"
    sessionSecret: "v4R7ZbCs26AdNa1z8D3H"

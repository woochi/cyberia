mongoose = require("mongoose")
Code = mongoose.model("Code")

policeCode = "84650A"
profileCode = "72030B"
mediaCode = "24910C"
corporationCode = "47210D"

generateCodes = (amount, value, difficulty) ->
  (for i in [1..amount]
    code = {}
    code.key = Math.random().toString(36).slice(2).substr(0, 6)
    code.value = value
    code.difficulty = difficulty
    code
  )

present = (codes) ->
  return codes.map (code) ->
    difficulty = switch code.difficulty
      when 0 then "helppo"
      when 1 then "normaali"
      when 2 then "vaikea"
      when 3 then "mahdoton"
    "#{code.key} - #{difficulty}"

exports.up = (next) ->
  police = []
  profiles = []
  media = []
  corporations = []

  police = police.concat generateCodes(3, policeCode, 0)
  police = police.concat generateCodes(3, policeCode, 1)
  police = police.concat generateCodes(3, policeCode, 2)
  police = police.concat generateCodes(3, policeCode, 3)
  
  profiles = profiles.concat generateCodes(3, profileCode, 0)
  profiles = profiles.concat generateCodes(3, profileCode, 1)
  profiles = profiles.concat generateCodes(3, profileCode, 2)
  profiles = profiles.concat generateCodes(3, profileCode, 3)

  media = media.concat generateCodes(3, mediaCode, 0)
  media = media.concat generateCodes(3, mediaCode, 1)
  media = media.concat generateCodes(3, mediaCode, 2)
  media = media.concat generateCodes(3, mediaCode, 3)

  corporations = corporations.concat generateCodes(3, corporationCode, 0)
  corporations = corporations.concat generateCodes(3, corporationCode, 1)
  corporations = corporations.concat generateCodes(3, corporationCode, 2)
  corporations = corporations.concat generateCodes(3, corporationCode, 3)

  console.log "Proxy-koodit [poliisi]:"
  console.log present(police)
  console.log "Proxy-koodit [profiilit]:"
  console.log present(profiles)
  console.log "Proxy-koodit [media]:"
  console.log present(media)
  console.log "Proxy-koodit [korporaatiot]:"
  console.log present(corporations)

  all = police.concat(profiles).concat(media).concat(corporations)
  console.log all
  Code.create all, next

exports.down = (next) ->
  Code.remove {}, next

Marionette = require("marionette")

class Penalty extends Marionette.ItemView
  template: require("../../templates/hacking/penalty.jade")
  id: "penalty"

  serializeData: ->
    i = @_getRandomInt 0, 1
    data = switch @model.get("difficulty")
      when 0
        [
          title: "Minor Failure"
          message: "NetWatch has detected usage of illegal software. Cease and desist."
          result: "Tätä netin sektoria tarkkaillaan. Et pääse etenemään."
        ,
          title: "Minor Failure"
          message: "NetWatch has detected attempt at accessing unauthorized material. Cease and desist."
          result: "Tätä netin sektoria tarkkaillaan. Et pääse etenemään."
        ]
      when 1
        [
          title: "Notable failure"
          message: "You are attempting to access unauthorized material. Your avatar has been logged and is being watched."
          result: "Olet vetänyt kuivat. Avatariasi tarkkaillaan, etkä voi liikkua netissä huomaamatta pariin päivään."
        ,
          title: "Notable failure"
          message: "Connection terminated. Your actions are illegal and your avatar is being watched."
          result: "Olet vetänyt kuivat. Avatariasi tarkkaillaan, etkä voi liikkua netissä huomaamatta pariin päivään."
        ]
      when 2
        [
          title: "Massive failure"
          message: "Unauthorized access. Connection terminated. A Pit Bull has been dispatched and the system has Stunned you."
          result: "Olet vetänyt kuivat, kätesi on toimintakyvytön seuraavan tunnin ajan järjestelmän ajamasta Stun-ohjelmasta johtuen. Pontus seuraa tätä sektoria."
        ,
          title: "Massive failure"
          message: "Unauthorized access. Connection terminated. A Viruzz has been dispatched."
          result: "Olet vetänyt kuivat, kätesi on tunnoton puolen tunnin ajan. Järjestelmän ajama Viruzz-ohjelma pyyhkii yhden dekkerin ohjelmista."
        ]
      when 3
        [
          title: "Critical failure"
          message: "Unauthorized access. Connection terminated. Black Ice. A Hellhound has been dispatched."
          result: "Vedit kuivat - yhteytesi on katkaistu. Musta ohjelma ajettu: Musti käy avatarisi kimppuun. Linkkiplugiisi tulee oikosulku. Menetät tajuntasi. Tarvitaan tekno ja/tai pätevä lekuri tai menetät kätesi pysyvästi. Musti seuraa avatariasi ajasta iäisyyteen."
        ,
          title: "Critical failure"
          message: "Unauthorized access. Connection terminated. Black Ice. Zombie has been activated."
          result: "Vedit kuivat - yhteytesi on katkaistu. Musta ohjelma ajettu: Zombie-ohjelma yritti käräyttää aivosi. Linkkiplugiisi tulee oikosulku. Menetät tajuntasi. Vakava sydämen toimintahäiriö."
        ]
    data[i]

  _getRandomInt: (min, max) ->
    Math.floor(Math.random() * (max - min + 1)) + min

module.exports = Penalty

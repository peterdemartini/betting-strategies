# Stolen somewhat from Roy van de Water because I am lazy
_ = require 'lodash'

class Roulette
  constructor: ->
    @pockets = @createPockets()

  bet: (amount=0) =>
    return amount if _.sample(@pockets) == 'black'
    return -amount

  createPockets: =>
    reds   = _.times 18, => 'red'
    blacks = _.times 18, => 'black'
    greens = _.times 2,  => 'green'
    [].concat reds, blacks, greens

module.exports = Roulette

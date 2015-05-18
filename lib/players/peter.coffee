_ = require 'lodash'
Player = require './player'

STRATEGIES =
  'sane': 'saneMultiplier'
  'random': 'getRandomMultiplier'
  'double': 'doubleDown'

class Aaron extends Player
  constructor: (gameName) ->
    @predictability = 1
    @strategies = _.keys STRATEGIES
    super(gameName)

  getRandomMultiplier: =>
    _.sample [1..3]

  doubleDown: => 2

  saneMultiplier: => 1

  setStrategy: (key='')=>
    @strategy = STRATEGIES[key]

  play: =>
    prevWinnings = @lastWinnings
    if @winningsPot == @minumum * 4 * @winningsMultiplier
      return false

    @bet()

    if @lastWinnings > 0
      @currentBet = @currentBet * @[@strategy]()
    else if @lastWinnings == 0
      @currentBet = prevWinnings
    else
      @currentBet = @minumum

    return true

module.exports = Aaron

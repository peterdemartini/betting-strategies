_ = require 'lodash'
Player = require './player'
CONTINUE_GAME = true

STRATEGIES =
  'same': 'keepTheSame'
  'random': 'getRandomMultiplier'
  'double': 'doubleDown'

class Peter extends Player
  constructor: (gameName) ->
    @predictability = 1
    @strategies = _.keys STRATEGIES
    super(gameName)

  getRandomMultiplier: =>
    _.sample [1..3]

  doubleDown: => 2

  keepTheSame: => 1

  setStrategy: (key)=>
    @strategy = STRATEGIES[key]

  play: =>
    prevWinnings = @lastWinnings
    if @winningsPot == @minumum * 4 * @winningsMultiplier
      return !CONTINUE_GAME

    @bet()

    if @lastWinnings > 0
      @currentBet = @currentBet * @[@strategy]()
    else if @lastWinnings == 0
      @currentBet = prevWinnings
    else
      @currentBet = @minumum

    return CONTINUE_GAME

module.exports = Peter

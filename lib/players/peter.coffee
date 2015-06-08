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

  getRandomMultiplier: => _.sample [1..3]

  doubleDown: => 2

  keepTheSame: => 1

  setStrategy: (key)=>
    @strategy = STRATEGIES[key]

  play: =>
    prevWinnings = @lastWinnings
    @bet()
    if @lastWinnings > 0
      @currentBet *= @[@strategy]()
    else if @lastWinnings == 0
      @currentBet = prevWinnings
    else
      @currentBet = @minumum

module.exports = Peter

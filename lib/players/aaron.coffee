_ = require 'lodash'
Player = require './player'

CONTINUE_GAME = true
STRATEGIES =
  'wrong': 'wrongStrategy'

class Aaron extends Player
  constructor: (gameName) ->
    @strategies = _.keys STRATEGIES
    super(gameName)

  wrongStrategy: => 2

  setStrategy: (key) =>
    @strategy = STRATEGIES[key]

  play: =>
    @winningsPot -= @currentBet
    @lastWinnings = @game.bet @currentBet
    @winningsPot += @lastWinnings

    if @lastWinnings <= 0
      @currentBet = @currentBet * @[@strategy]()
      return CONTINUE_GAME

    @currentBet = @minumum
    return CONTINUE_GAME

module.exports = Aaron

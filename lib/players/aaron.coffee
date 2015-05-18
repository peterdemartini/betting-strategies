_ = require 'lodash'
Player = require './player'

STRATEGIES =
  'wrong': 'wrongStrategy'

class Aaron extends Player
  constructor: (gameName='roulette', dependencies={}) ->
    @strategies = _.keys STRATEGIES
    super(gameName, dependencies)

  wrongStrategy: => 2

  setStrategy: (key='')=>
    @strategy = STRATEGIES[key]

  play: =>
    @winningsPot -= @currentBet
    @lastWinnings = @game.bet @currentBet
    @winningsPot += @lastWinnings

    if @lastWinnings <= 0
      @currentBet = @currentBet * @[@strategy]()
      return true

    @currentBet = @minumum
    return true

module.exports = Aaron

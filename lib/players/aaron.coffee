_ = require 'lodash'
Player = require './player'

STRATEGIES =
  'wrong': 'wrongStrategy'

class Aaron extends Player
  constructor: (gameName) ->
    @strategies = _.keys STRATEGIES
    super(gameName)
    @minumum = 1
    @winningsPot = 1
    @currentBet = 1

  wrongStrategy: => 2

  setStrategy: (key) =>
    @strategy = STRATEGIES[key]

  play: =>
    @winningsPot -= @currentBet
    @lastWinnings = @game.bet @currentBet
    @winningsPot += @lastWinnings

    if @lastWinnings <= 0
      @currentBet *= @[@strategy]()
    else
      @currentBet = @minumum


module.exports = Aaron

PREDICTABLITY = 5

class Peter
  constructor: (gameName='roulette', dependencies={}) ->
    Game = require './games/' + gameName
    @game = new Game
    @minumum = 5
    @currentBet = @minumum
    @totalBet = 0
    @lastWinnings = 0
    @winningsPot = 0

  getRandomMultiplier: ->
    Math.floor(Math.random() * PREDICTABLITY)

  play: =>
    @lastWinnings = @game.bet @currentBet, on: 'black'
    @totalBet += @currentBet
    @winningsPot += @lastWinnings

    if @lastWinnings > 0 
      @currentBet = @currentBet * @getRandomMultiplier()
    else
      @currentBet = @minumum
    return null

module.exports = Peter
class Player
  constructor: (gameName) ->
    Game = require '../games/' + gameName
    @game = new Game
    @minumum = 25
    @currentBet = @minumum
    @lastWinnings = 0
    @winningsPot = 25

  bet: =>
    console.error('bet a negative amount') if @currentBet < 0
    console.error("can't bet 0") if @currentBet == 0
    @winningsPot -= @currentBet
    @lastWinnings = @game.bet @currentBet
    @winningsPot += @lastWinnings

module.exports = Player

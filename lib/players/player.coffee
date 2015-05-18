class Player
  constructor: (gameName='roulette') ->
    Game = require '../games/' + gameName
    @game = new Game
    @minumum = 25
    @currentBet = @minumum
    @lastWinnings = 0
    @winningsPot = 25

  bet: =>
    throw new Error('bet a negative amount') if @currentBet < 0
    throw new Error("can't bet 0") if @currentBet == 0
    @winningsPot -= @currentBet
    @lastWinnings = @game.bet @currentBet
    @winningsPot += @lastWinnings

module.exports = Player

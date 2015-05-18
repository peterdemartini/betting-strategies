class Player
  constructor: (gameName='roulette', dependencies={}) ->
    Game = require '../games/' + gameName
    @game = new Game
    @minumum = 25
    @currentBet = @minumum
    @lastWinnings = 0
    @winningsPot = 0

module.exports = Player

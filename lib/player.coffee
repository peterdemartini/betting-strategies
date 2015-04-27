class Peter
  constructor: (gameName='roulette', dependencies={}) ->
    @predictability = 1
    Game = require './games/' + gameName
    @game = new Game
    @minumum = 25
    @currentBet = @minumum
    @lastWinnings = 0
    @winningsPot = 0
    @MULTIPLIERS =
      'sane': 'saneMultiplier'
      'random': 'getRandomMultiplier'
      'double': 'doubleDown'
    @multiplier = @MULTIPLIERS.sane
    @winningsMultiplier = 4

  getRandomMultiplier: =>
    Math.floor Math.random() * @predictability

  saneMultiplier: =>
    @predictability

  doubleDown: => 2

  setMultiplier: (key='')=>
    @multiplier = @MULTIPLIERS[key]

  play: =>
    prevWinnings = @lastWinnings
    if @winningsPot == @minumum * 4 * @winningsMultiplier
      return false

    prevWinnings = @lastWinnings
    @lastWinnings = @game.bet @currentBet
    @winningsPot += @lastWinnings

    if @lastWinnings > 0
      @currentBet = @currentBet * @[@multiplier]()
    else if @lastWinnings == 0
      @currentBet = prevWinnings
    else
      @currentBet = @minumum
    return true

module.exports = Peter

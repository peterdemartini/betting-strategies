class Peter
  constructor: (gameName='roulette', dependencies={}) ->
    @predictability = 1
    Game = require './games/' + gameName
    @game = new Game
    @minumum = 20
    @currentBet = @minumum
    @lastWinnings = 0
    @winningsPot = 0
    @MULTIPLIERS =
      'sane': 'saneMultiplier'
      'random': 'getRandomMultiplier'
      'double': 'doubleDown'
    @multiplier = @MULTIPLIERS.sane
    @happyWithWinnings = @minumum * 10

  getRandomMultiplier: =>
    Math.floor Math.random() * @predictability

  saneMultiplier: =>
    @predictability

  doubleDown: => 2

  setMultiplier: (key='')=>
    @multiplier = @MULTIPLIERS[key]

  play: =>
    # if @winningsPot > @happyWithWinnings
    #   @lastWinnings = 0
    #   return null
    # @predictability++
    @lastWinnings = @game.bet @currentBet
    @winningsPot += @lastWinnings

    if @lastWinnings > 0
      @currentBet = @currentBet * @[@multiplier]()
      # @currentBet = @currentBet * @saneMultiplier()
    else
      @currentBet = @minumum
    return null

module.exports = Peter

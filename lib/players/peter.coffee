Player = require './player'

class Peter extends Player
  constructor: (gameName='roulette', dependencies={}) ->
    @predictability = 1
    @minumum = 25
    @MULTIPLIERS =
      'sane': 'saneMultiplier'
      'random': 'getRandomMultiplier'
      'double': 'doubleDown'
    @multiplier = @MULTIPLIERS.sane
    @winningsMultiplier = 4
    @strategies = ['random', 'sane', 'double']
    super()

  getRandomMultiplier: =>
    Math.floor Math.random() * @predictability

  saneMultiplier: =>
    @predictability

  doubleDown: => 2

  setStrategy: (key='')=>
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

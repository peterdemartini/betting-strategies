_ = require 'lodash'
colors = require 'colors/safe'
Player = require "./lib/player"

class GameRunner
  constructor: (@multipliers=[], @numberOfGames=20, @gameName='roulette') ->
    @limitSize = @numberOfGames / 5 if @numberOfGames > 20
    @limitSize = @numberOfGames / 2 if @numberOfGames <= 20

  formatNumber: (number) ->
    n = number.toString()
    formatRegex = /(\d)(?=(\d\d\d)+(?!\d))/g
    return '$' + n.replace(formatRegex, "$1,") if number > 0
    '-$' + n.replace('-', '').replace(formatRegex, "$1,")

  newPerson: =>
    @player = new Player @gameName

  runLimitGame: (index) =>
    result = @player.play()
    lastWinnings = @player.lastWinnings
    if lastWinnings > 0
      @numberWon++
    else if lastWinnings < 0
      @numberLost++
    return unless @isEndOfLimitGame(index)
    return unless result
    @totalWinnings = @player.winningsPot
    @limitGamesPlayed++
    console.log "Limit Game (#{@limitGamesPlayed}): #{@formatNumber(@totalWinnings)}"
    @newPerson()

  runMultiplier: (multiplier) =>
    @reset()
    console.log colors.grey("Running multiplier [#{multiplier}]")
    @newPerson()
    @player.setMultiplier(multiplier)
    _.times @numberOfGames, @runLimitGame
    console.log colors.cyan("Total Winnings: #{@formatNumber(@totalWinnings)}")
    winningRatio = Math.round(@numberWon / @numberOfGames  * 100)
    console.log colors.green("Winning Ratio: %#{winningRatio}")

  run: =>
    _.each @multipliers, @runMultiplier

  reset: =>
    @numberWon = 0
    @numberLost = 0
    @totalWinnings = 0
    @limitGamesPlayed = 0

  isEndOfLimitGame: (n) =>
    n % @limitSize == @limitSize - 1

module.exports = GameRunner

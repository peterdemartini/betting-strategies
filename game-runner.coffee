_ = require 'lodash'
Player = require "./lib/player"

class GameRunner
  constructor: (@multipliers=[], @numberOfGames=20, @gameName='roulette') ->
    @numberWon = 0
    @numberLost = 0
    @totalWinnings = 0
    @limitGamesPlayed = 0
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
    @player.play()
    lastWinnings = @player.lastWinnings
    if lastWinnings > 0
      @numberWon++
    else if lastWinnings < 0
      @numberLost++
    return unless @isEndOfLimitGame(index)
    @totalWinnings = @player.winningsPot
    @limitGamesPlayed++
    console.log "Limit Game: #{@formatNumber(@totalWinnings)}"
    @newPerson()

  runMultiplier: (multiplier) =>
    @newPerson()
    @player.setMultiplier(multiplier)
    _.times @numberOfGames, @runLimitGame
    console.log "Total Winnings: #{@formatNumber(@totalWinnings)}"
    winningRatio = Math.round(@numberWon / @numberOfGames  * 100)
    console.log "Winning Ratio: %#{winningRatio}"

  run: =>
    _.each @multipliers, @runMultiplier

  isEndOfLimitGame: (n) =>
    n % @limitSize == @limitSize - 1

module.exports = GameRunner

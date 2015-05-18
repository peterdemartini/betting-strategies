_ = require 'lodash'
EasyTable = require 'easy-table'
colors = require 'colors/safe'
debug = require('debug')('betting-strategy:game-runner')
Peter = require './players/peter'
Aaron = require './players/aaron'
PLAYERS = {
  'peter': Peter,
  'aaron': Aaron
}

class GameRunner
  constructor: (@numberOfGames=20, @gameName) ->
    @results = []

  formatNumber: (number) ->
    n = number.toString()
    formatRegex = /(\d)(?=(\d\d\d)+(?!\d))/g
    return '$' + n.replace(formatRegex, "$1,") if number > 0
    '-$' + n.replace('-', '').replace(formatRegex, "$1,")

  newPerson: (Player) =>
    @player = new Player(@gameName)

  runGame: (index) =>
    @gamesPlayed++
    result = @player.play()
    lastWinnings = @player.lastWinnings
    if lastWinnings > 0
      @numberWon++
    else if lastWinnings < 0
      @numberLost++
      
    if @numberOfGames == @gamesPlayed
      @totalWinnings = @player.winningsPot

  runPlayer: (Player, playerName) =>
    @newPerson(Player)
    _.each @player.strategies, (strategy) =>
      @reset()
      result = {}
      @player.setStrategy(strategy)
      _.times @numberOfGames, @runGame
      winningRatio = Math.round(@numberWon / @numberOfGames  * 100)
      result["Player"] = playerName
      result["Strategy"] = strategy
      result["Total Winnings"] = @formatNumber(@totalWinnings)
      result["Games Played"] = @gamesPlayed
      result["Ratio"] = "%#{winningRatio}"
      @results.push result
      @newPerson(Player)

  run: =>
    _.each PLAYERS, @runPlayer

  reset: =>
    @numberWon = 0
    @numberLost = 0
    @totalWinnings = 0
    @gamesPlayed = 0

  output: =>
    console.log EasyTable.printArray(@results)


module.exports = GameRunner

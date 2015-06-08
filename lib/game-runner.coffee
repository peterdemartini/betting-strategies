_ = require 'lodash'
formatNumber = require './format-number'
EasyTable = require 'easy-table'
Peter = require './players/peter'
Aaron = require './players/aaron'
PLAYERS = {
  'peter': Peter,
  'aaron': Aaron
}

class GameRunner
  constructor: (@numberOfGames=20, @gameName) ->
    @results = []

  newPerson: (Player) =>
    @player = new Player(@gameName)

  runGame: (index) =>
    @gamesPlayed++
    @player.play()
    lastWinnings = @player.lastWinnings
    @numberWon++ if lastWinnings > 0
    @numberLost++ if lastWinnings < 0
    @betAmounts.push(@player.currentBet)

    if @numberOfGames == @gamesPlayed
      @totalWinnings = @player.winningsPot

  runPlayer: (Player, playerName) =>
    @newPerson(Player)
    _.each @player.strategies, (strategy) =>
      @reset()
      result = {}
      @player.setStrategy(strategy)
      _.times @numberOfGames, @runGame
      result["Player"] = playerName
      result["Strategy"] = strategy
      result["Minumum"] = @player.minumum
      result["Total Won"] = '$' + formatNumber(@totalWinnings)
      result["# Played"] = @gamesPlayed
      result["Won / Lost"] = "#{@numberWon}/#{@numberLost}"
      winningRatio = Math.round(@numberWon / @numberOfGames  * 100)
      result["Ratio"] = "%#{winningRatio}"
      result["Highest Bet"] = formatNumber _.max(@betAmounts)
      @results.push result
      @newPerson(Player)

  run: =>
    _.each PLAYERS, @runPlayer

  reset: =>
    @betAmounts = []
    @numberWon = 0
    @numberLost = 0
    @totalWinnings = 0
    @gamesPlayed = 0

  output: =>
    console.log EasyTable.printArray(@results)

module.exports = GameRunner

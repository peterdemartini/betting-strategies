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
      result["Total Winnings"] = formatNumber(@totalWinnings)
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

program = require 'commander'
packageJSON = require './package.json'
GameRunner = require './game-runner'

program
  .version packageJSON.version
  .option '-g, --game', "Game to play. ['blackjack', 'roulette']"
  .option '-n, --number', "Number of games to play."
  .parse process.argv

gameName = program.game || 'roulette'
defaultNumberOfGames = '20'.replace(/,/g, '')
numberOfGames = parseInt program.number || defaultNumberOfGames

console.log 'Starting Games...'

multipliers = ['random', 'sane', 'double']
gameRunner = new GameRunner(multipliers, numberOfGames, gameName)
gameRunner.run()

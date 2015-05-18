program = require 'commander'
packageJSON = require './package.json'
GameRunner = require './lib/game-runner'
debug = require('debug')('betting-strategy:run')

program
  .version packageJSON.version
  .option '-g, --game', "Game to play. ['blackjack', 'roulette']"
  .option '-n, --number', "Number of games to play."
  .parse process.argv

gameName = program.game || 'roulette'
defaultNumberOfGames = '2,000,000'.replace(/,/g, '')
numberOfGames = parseInt program.number || defaultNumberOfGames

debug 'Starting Games...'

gameRunner = new GameRunner(numberOfGames, gameName)
gameRunner.run()
gameRunner.output();

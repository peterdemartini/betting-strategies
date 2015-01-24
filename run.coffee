_ = require 'lodash'

args = process.argv.slice 2
personName = args[0] ? 'peter'
gameName = args[1] ? 'roulette'
defaultNumberOfGames = '2,000'.replace(/,/g, '')
numberOfGames = parseInt args[1] ? parseInt defaultNumberOfGames
limitSize = numberOfGames

Person = require './lib/' + personName

console.log 'Starting Game...'

formatNumber = (number) -> 
  if number > 0
    '$' + number.toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,")
  else
    '-$' + number.toString().replace('-', '').replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,")

person = new Person(gameName)
totalWinnings = 0
totalBet = 0
numberWon = 0
numberLost = 0
_.times numberOfGames, (index) =>
  person.play()
  if person.lastWinnings > 0 
    numberWon++
  else
    numberLost++
  if index % 1000 == 999
    totalWinnings += person.winningsPot 
    totalBet += person.totalBet 
    console.log 'Limit Game Winnings: ' + formatNumber(person.winningsPot)
    person = new Person(gameName)


console.log 'Total Winnings: ' + formatNumber totalWinnings 
console.log 'Total Bet: ' + formatNumber totalBet 
console.log 'Winning Ratio: %' + Math.round(numberWon / numberOfGames  * 100)

_ = require 'lodash'

class BlackJack
  constructor: ->
    @cards = @createDecks()

  drawCard: =>
    card = _.sample @cards
    @cards = _.without @cards, card
    @cards = @createDecks() if _.size(@cards) == 0
    card

  getHand: =>
    hand = _.times 2, @drawCard
    total = _.sum hand
    return 0 if total == 21 # BlackJack
    while total < 17
      card = @drawCard()
      hand.push card
      total = _.sum hand
    total

  bet: (amount=0) =>
    dealer = @getHand()
    person = @getHand()
    return amount if person == 0 # BlackJack
    return -amount if dealer == 0 # BlackJack
    return amount if person > dealer
    return -amount

  createSuit: (n) =>
    return n if n % 13 < 10
    return 10

  createDecks: (numberOfDecks=5)=>
    numberOfCardsInASuit = 13
    numberOfSuits = 4
    numberOfCards = numberOfDecks * numberOfSuits * numberOfCardsInASuit
    decks = _.times numberOfCards, @createSuit
    decks

module.exports = BlackJack

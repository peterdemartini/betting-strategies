_ = require 'lodash'

class BlackJack
  constructor: (dependencies={}) ->
    @sample = dependencies.sample ? _.sample

module.exports = BlackJack
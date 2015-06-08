module.exports = (number) ->
  n = number.toString()
  formatRegex = /(\d)(?=(\d\d\d)+(?!\d))/g
  return n.replace(formatRegex, "$1,") if number > 0
  return '-' + n.replace('-', '').replace(formatRegex, "$1,")

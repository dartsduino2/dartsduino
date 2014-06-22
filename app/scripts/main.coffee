'use strict'

dartsUi = document.querySelector 'darts-ui'
dartsUi.addEventListener 'hit', (event) ->
  {score, ratio} = event.detail
  console.log score + ', ' + ratio + ' = ' + score * ratio

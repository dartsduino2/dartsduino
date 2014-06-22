'use strict'

Polymer('game-501', {

  dartsUi: null

  ready: ->
    @dartsUi = document.querySelector 'darts-ui'

  activeChanged: (oldValue, newValue) ->
    if newValue isnt null
      @activate()
    else
      @deactivate()

  activate: ->
    @dartsUi.addEventListener 'hit', @onHit

  deactivate: ->
    @dartsUi.removeEventListener 'hit', @onHit

  onHit: (event) ->
    {score, ratio} = event.detail
    console.log score + ', ' + ratio + ' = ' + score * ratio

});

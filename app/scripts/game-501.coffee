'use strict'

Polymer('game-501', {

  State:
    NOT_STARTED: 0
    PLAYING: 1

  state: null

  dartsUi: null

  totalScore: null
  scores: []
  round: null
  count: null

  ready: ->
    @dartsUi = document.querySelector 'darts-ui'

    @state = @State.NOT_STARTED

  activeChanged: (oldValue, newValue) ->
    if newValue isnt null
      @activate()
    else
      @deactivate()

  activate: ->
    @dartsUi.addEventListener 'hit', (@onHit).bind @
    @dartsUi.setAttribute 'focuses', ''

    @totalScore = 501
    @scores = []
    @round = 1
    @count = 1

    @state = @State.PLAYING

  deactivate: ->
    @dartsUi.removeEventListener 'hit', (@onHit).bind @

    @state = @State.NOT_STARTED

  onHit: (event) ->
    {score, ratio} = event.detail

    @scores.push score * ratio
    console.log @scores

    prevScore = @totalScore
    @totalScore -= (score * ratio)
    if @totalScore < 0
      @totalScore = prevScore
    else if @totalScore is 0
      @finish()

    @count++
    if @count > 3
      @count = 1
      @round++

  finish: ->
    console.log 'Finish!'

});

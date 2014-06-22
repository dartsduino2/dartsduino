'use strict'

Polymer('game-501', {

  State:
    NOT_STARTED: 0
    PLAYING: 1

  state: null

  dartsUi: null
  listeners: []

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
    @addEventListener 'hit', @onHit.bind(@)

    @dartsUi.setAttribute 'focuses', ''

    @totalScore = 501
    @scores = []
    @round = 1
    @count = 1

    @state = @State.PLAYING

  deactivate: ->
    @removeEventListener()

    @state = @State.NOT_STARTED

  onHit: (event) ->
    if @count is 1
      @scores.push []

    {score, ratio} = event.detail

    @scores[@scores.length - 1].push score * ratio

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
    @deactivate()

  addEventListener: (event, listener) ->
    @dartsUi.addEventListener event, listener
    @listeners.push {event, listener}

  removeEventListener: ->
    for {event, listener} in @listeners
      @dartsUi.removeEventListener event, listener
});

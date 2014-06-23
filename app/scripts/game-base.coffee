'use strict'

Polymer 'game-base',

  State:
    NOT_STARTED: 0
    PLAYING: 1

  dartsUi: null
  state: null
  listeners: []
  title: ''

  totalScore: null
  scores: []
  round: null
  count: null

  ready: ->
    @dartsUi = document.querySelector 'darts-ui'

    @state = @State.NOT_STARTED

    @initialize?()

    @setVisibility false

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

    @setVisibility true

    @state = @State.PLAYING

  deactivate: ->
    @removeEventListener()

    @setVisibility false

    @state = @State.NOT_STARTED

  setVisibility: (isVisible) ->
    if isVisible
      @.classList.remove 'invisible'
    else
      @.classList.add 'invisible'

  onHit: (event) ->
    {score, ratio} = event.detail
    console.log score + ' * ' + ratio + ' = ' + score * ratio

  finish: ->
    console.log 'Finish!'
    @deactivate()

  addEventListener: (event, listener) ->
    @dartsUi.addEventListener event, listener
    @listeners.push {event, listener}

  removeEventListener: ->
    for {event, listener} in @listeners
      @dartsUi.removeEventListener event, listener

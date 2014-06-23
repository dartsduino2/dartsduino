'use strict'

Polymer 'game-base',

  State:
    NOT_STARTED: 0
    PLAYING: 1
    FINISHED: 2

  dartsUi: null
  state: null
  listeners: []
  title: ''

  playerList: null
  currentPlayerIndex: null

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

    @start?()

    @state = @State.PLAYING

    @setVisibility true

  deactivate: ->
    @removeEventListener()

    @state = @State.NOT_STARTED

    @setVisibility false

  setVisibility: (isVisible) ->
    if isVisible
      @.classList.remove 'invisible'
    else
      @.classList.add 'invisible'

  onHit: (event) ->
    {point, ratio} = event.detail
    console.log point + ' * ' + ratio + ' = ' + point * ratio

  finish: ->
    console.log 'Finish!'

    @removeEventListener()

    @state = @State.FINISHED

  addEventListener: (event, listener) ->
    @dartsUi.addEventListener event, listener
    @listeners.push {event, listener}

  removeEventListener: ->
    for {event, listener} in @listeners
      @dartsUi.removeEventListener event, listener

  playersChanged: (oldValue, newValue) ->
    @playerList = []
    for i in [1..newValue]
      player =
        id: i - 1
        name: 'Player ' + i
      @playerList.push player

    console.log @playerList

    @currentPlayerIndex = 0

  getCurrentPlayer: ->
    return @playerList[@currentPlayerIndex]

  nextPlayer: ->
    @currentPlayerIndex++
    if @currentPlayerIndex >= @playerList.length
      @currentPlayerIndex = 0

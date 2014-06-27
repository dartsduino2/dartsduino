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
  currentPlayer: null
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

    @playerList = []
    for i in [1..(@players || 1)]
      player =
        id: i - 1
        name: 'Player ' + i
      @playerList.push player
    @currentPlayerIndex = 0
    @currentPlayer = @playerList[@currentPlayerIndex]

    @start?()

    @state = @State.PLAYING

    @setVisibility true

  deactivate: ->
    @removeEventListener()

    @state = @State.NOT_STARTED

    @setVisibility false

  setVisibility: (isVisible) ->
    if isVisible
      # @.classList.remove 'invisible'
      @.style.visibility = 'visible'
    else
      # @.classList.add 'invisible'
      @.style.visibility = 'hidden'

  onHit: (event) ->
    {point, ratio} = event.detail
    console.log point + ' * ' + ratio + ' = ' + point * ratio

  finish: (result) ->
    # console.log 'Finish!'

    @removeEventListener()

    @state = @State.FINISHED

    @.fire 'finish', result

  addEventListener: (event, listener) ->
    @dartsUi.addEventListener event, listener
    @listeners.push {event, listener}

  removeEventListener: ->
    for {event, listener} in @listeners
      @dartsUi.removeEventListener event, listener

    return

  nextPlayer: ->
    isNext = false
    @currentPlayerIndex++
    if @currentPlayerIndex >= @playerList.length
      @currentPlayerIndex = 0
      isNext = true

    @currentPlayer = @playerList[@currentPlayerIndex]

    return isNext

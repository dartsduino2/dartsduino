'use strict'

Polymer 'game-time-attack',

  MAX_COUNT: 30
  MAX_PRECOUNT: 3

  score: null
  timer: null
  count: null

  preTimer: null
  preCount: null

  initialize: ->
    @title = 'タイムアタック'

  start: ->
    @score = 0
    @count = @MAX_COUNT
    @tick()

    @preCount = @MAX_PRECOUNT
    @preTimer = setInterval =>
      @preCount--
      @tick()

      if @preCount is 0
        @preCount = ''
        clearInterval @preTimer
        @preTimer = null

        @doStart()
    , 1000

  tick: ->
    @.$.precount.classList.remove 'tick'
    setTimeout =>
      @.$.precount.classList.add 'tick'
    , 100

  doStart: ->
    @timer = setInterval =>
      @count--

      if @count is 3
        @.$.count.classList.add 'alert'
      else if @count is 0
        @over()
    , 1000

  onHit: (event) ->
    if @timer is null
      return

    point = parseInt event.detail.point
    ratio = parseInt event.detail.ratio
    @score += point * ratio

  over: ->
    # console.log 'over'

    clearInterval @timer
    @timer = null

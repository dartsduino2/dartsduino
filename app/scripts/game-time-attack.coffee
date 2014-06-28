'use strict'

Polymer 'game-time-attack',

  MAX_COUNT: 30

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

    @preCount = 3
    @preTimer = setInterval =>
      @preCount--

      if @preCount is 0
        clearInterval @preTimer
        @preTimer = null

        @doStart()
    , 1000

  doStart: ->
    @timer = setInterval =>
      @count--

      if @count is 0
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

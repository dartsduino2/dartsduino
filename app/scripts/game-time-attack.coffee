'use strict'

Polymer 'game-time-attack',

  MAX_COUNT: 30
  COUNT_DURATION: 1000
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
    , @COUNT_DURATION

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
    , @COUNT_DURATION

  stop: ->
    if @preTimer?
      clearInterval @preTimer
      @preTimer = null

    if @timer
      clearInterval @timer
      @timer = null

  onHit: (event) ->
    return unless @timer?

    point = parseInt event.detail.point
    ratio = parseInt event.detail.ratio
    @score += point * ratio

  over: ->
    @stop()

    @finish
      message: "スコア: #{@score}"

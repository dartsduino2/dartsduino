'use strict'

Polymer 'game-time-attack',

  MAX_COUNT: 30

  score: null
  timer: null
  count: null

  initialize: ->
    @title = 'タイムアタック'

  start: ->
    @score = 0
    @count = @MAX_COUNT

    @timer = setInterval =>
      if @count is 0
        @over()
      else
        @count--
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

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

  over: ->
    # console.log 'over'

    clearInterval @timer

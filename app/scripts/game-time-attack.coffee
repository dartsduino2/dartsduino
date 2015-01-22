'use strict'

Polymer 'game-time-attack',

  INTERVAL_DURATION: 1000
  COUNT: 30
  PRECOUNT: 3
  NO_COUNT: 3

  score: null
  timer: null
  count: null

  sound: null

  initialize: ->
    @title = 'タイムアタック'

  start: ->
    @score = 0
    @maxScore = localStorage['time-attack'] || 0
    @timeLeft = @COUNT

    @count = @COUNT + @PRECOUNT + @NO_COUNT + 1
    @timer = setInterval =>
      @tick()

      @count--
      if @count > @COUNT + @PRECOUNT
      else if @COUNT + @PRECOUNT >= @count > @COUNT
        @jumbotext = @count - @COUNT
        @sound.play 'click'
      else if @count is @COUNT
        @jumbotext = ''
      else
        @timeLeft = @count

        if @count <= 5
          @sound.play 'click'

        @over() if @count <= 0
    , @INTERVAL_DURATION

    @sound = new Sound()

  tick: ->
    @jumbotextClass = ''
    setTimeout =>
      @jumbotextClass = 'tick'
    , 0

  stop: ->
    if @timer?
      clearInterval @timer
      @timer = null

  onHit: (event) ->
    return unless @timer?

    point = parseInt event.detail.point
    ratio = parseInt event.detail.ratio
    @score += point * ratio

  over: ->
    @stop()

    isMaxScore = @score > @maxScore
    if isMaxScore
      localStorage['time-attack'] = @score

    @finish
      message: "得点: #{@score}" + (if isMaxScore then '　★本日の最高得点!★' else '')

'use strict'

Polymer 'game-cricket',

  POINTS: [20, 19, 18, 17, 16, 15, 'Bull']
  MARKS: [[''], ['／'], ['／', '＼'], ['／', '＼', '◯']]
  MAX_SCORE: 3

  totalScores: {}
  scores: {}
  closedPoint: {}
  round: null
  count: null

  initialize: ->
    @title = 'Cricket'

  start: ->
    @totalScores = {}
    @scores = {}
    for player in @playerList
      @totalScores[player.id] = 0

      @scores[player.id] = {}
      for point in @POINTS
        @scores[player.id][point] = 0

    @round = 1
    @count = 1

  onHit: (event) ->
    id = @currentPlayer.id

    point = parseInt event.detail.point
    ratio = parseInt event.detail.ratio

    if point >= 15
      score = point * ratio

      if point is 25
        point = 'Bull'

      if @scores[id][point] >= @MAX_SCORE
        if not @closedPoint[point]?
          @totalScores[id] += score
      else
        @scores[id][point] += ratio

        if @scores[id][point] >= @MAX_SCORE
          @scores[id][point] = @MAX_SCORE

          if @scores[1 - id][point] >= @MAX_SCORE
            @closedPoint[point] = true

    # console.log @scores
    # console.log @closedPoint

    @count++
    if @count > 3
      @count = 1
      isNextRound = @nextPlayer()

      if isNextRound
        @round++

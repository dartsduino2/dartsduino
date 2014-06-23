'use strict'

Polymer 'game-cricket',

  POINTS: [20, 19, 18, 17, 16, 15, 'Bull']
  MARKS: [[''], ['／'], ['／', '＼'], ['／', '＼', '◯']]
  MAX_SCORE: 3

  scores: {}
  round: null
  count: null

  initialize: ->
    @title = 'Cricket'

  start: ->
    scores = {}
    for player in @playerList
      @scores[player.id] = {}

    @round = 1
    @count = 1

  onHit: (event) ->
    id = @getCurrentPlayer().id

    point = parseInt event.detail.point
    ratio = parseInt event.detail.ratio

    if point >= 15
      if point is '25'
        point = 'Bull'

      if @scores[id][point]?
        @scores[id][point] += ratio
        if @scores[id][point] > @MAX_SCORE
          @scores[id][point] = @MAX_SCORE
      else
        @scores[id][point] = ratio

    # console.log @scores

    @count++
    if @count > 3
      @count = 1
      isNextRound = @nextPlayer()

      if isNextRound
        @round++

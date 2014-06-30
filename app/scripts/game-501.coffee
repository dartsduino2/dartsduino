'use strict'

Polymer 'game-501',

  MAX_ROUND: 8

  totalScores: null
  scores: null
  round: null
  count: null

  initialize: ->
    @title = 501

  start: ->
    @totalScores = {}
    @scores = {}
    for player in @playerList
      @totalScores[player.id] = 501

      @scores[player.id] = []

    @round = 1
    @count = 1

  onHit: (event) ->
    id = @currentPlayer.id

    point = parseInt event.detail.point
    ratio = parseInt event.detail.ratio
    score = point * ratio

    if @count is 1
      @scores[id].push score
    else
      @scores[id][@scores[id].length - 1] += score

    prevScore = @totalScores[id]
    @totalScores[id] -= score
    if @totalScores[id] < 0
      @totalScores[id] = prevScore
    else if @totalScores[id] is 0
      @over @currentPlayer

    @count++
    if @count > 3
      @count = 1
      isNextRound = @nextPlayer()

      if isNextRound
        if @round >= @MAX_ROUND
          @over()
        else
          @round++

  over: (winner) ->
    if not winner?
      winner = []
      score = 1000
      for player in @playerList
        if score is @totalScores[player.id]
          winner.push player
        else if score > @totalScores[player.id]
          winner = [player]
          score = @totalScores[player.id]

      winner = if winner.length > 1 then null else winner[0]

    @finish
      player: winner
      score: score

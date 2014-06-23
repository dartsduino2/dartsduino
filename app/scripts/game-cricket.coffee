'use strict'

Polymer 'game-cricket',

  POINTS: [20, 19, 18, 17, 16, 15, 'Bull']
  MARKS: [[''], ['／'], ['／', '＼'], ['／', '＼', '◯']]

  scores: {}

  initialize: ->
    @title = 'Cricket'

  onHit: (event) ->
    {point, ratio} = event.detail

    if point < 15
      return
    else if point is '25'
      point = 'Bull'

    if @scores[point]?
      @scores[point] += 1
      if @scores[point] > 3
        @scores[point] = 3
    else
      @scores[point] = 1

    console.log @scores

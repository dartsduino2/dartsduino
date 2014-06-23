'use strict'

Polymer 'game-501',

  initialize: ->
    @title = 501

  onHit: (event) ->
    if @count is 1
      @scores.push []

    {point, ratio} = event.detail

    @scores[@scores.length - 1].push point * ratio

    prevScore = @totalScore
    @totalScore -= (point * ratio)
    if @totalScore < 0
      @totalScore = prevScore
    else if @totalScore is 0
      @finish()

    @count++
    if @count > 3
      @count = 1
      @round++

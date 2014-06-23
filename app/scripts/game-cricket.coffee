'use strict'

Polymer 'game-cricket',

  POINTS: [20, 19, 18, 17, 16, 15, 'Bull']

  initialize: ->
    @title = 'Cricket'

  onHit: (event) ->
    {point, ratio} = event.detail
    console.log point

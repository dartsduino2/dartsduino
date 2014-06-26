'use strict'

Polymer 'game-group',

  publish:
    games:
      value: ''
      reflect: true

  domReady: ->
    games = []
    for game in @.$.games.children
      games.push game.getAttribute 'title'

    @games = games.join ','

'use strict'

Polymer 'game-group',

  publish:
    games:
      value: ''
      reflect: true
    state:
      value: ''
      reflect: true

  domReady: ->
    games = []
    for game in @.$.games.children
      games.push game.getAttribute 'title'

    @games = games.join ','

  stateChanged: (oldValue, newValue) ->
    [title, players] = newValue.split ','

    index = @games.split(',').indexOf title
    game = @.$.games.children[index]

    game.setAttribute 'players', players
    game.setAttribute 'active', ''
    game.addEventListener 'finish', @onFinish

  onFinish: ->
    console.log 'Finished'

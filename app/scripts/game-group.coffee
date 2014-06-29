'use strict'

Polymer 'game-group',

  activeGame: null

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
      games.push game.title

    @games = games.join ','

    # console.log @games
    @activateGame 'タイムアタック'

  stateChanged: (oldValue, newValue) ->
    if newValue?
      [title, players] = newValue.split ','
      @activateGame title, players
    else
      @deactivateGame()

  activateGame: (title, players) ->
    index = @games.split(',').indexOf title
    @activeGame = @.$.games.children[index]

    @activeGame.setAttribute 'players', players
    @activeGame.setAttribute 'active', ''

  deactivateGame: ->
    @activeGame.removeAttribute 'active'

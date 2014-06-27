'use strict'

class Game

  State =
    NOT_STARTED: 0
    PLAYING: 1

  state: State.NOT_STARTED
  gameGroup: null

  constructor: ->
    @resizeWindow()
    $(window).resize =>
      @resizeWindow()

    $('#start-button').click @start
    $('#select-button').click @select
    $('#cancel-button').click @cancel
    $('#result-ok').click @initialize

    @gameGroup = document.querySelector 'game-group'
    @gameGroup.addEventListener 'finish', @onFinish

  resizeWindow: ->
    bodyHeight = $('body').height()
    headerHeight = $('.header').height() + 11
    footerHeight = $('.footer').height() + 11
    height = bodyHeight - headerHeight - footerHeight - 36
    length = (Math.min $('body').width(), height) - 20
    marginLeft = ($('.container').width() - length) / 2

    $('darts-ui')
      .attr 'width', length
      .attr 'height', length
      .css 'margin-left', marginLeft

  initialize: =>
    @gameGroup.removeAttribute 'state'

  start: =>
    games = (@gameGroup.getAttribute 'games').split ','

    gameItems = $('#gameItems')
    gameItems.empty()

    for game, i in games
      checked = if i is 0 then 'checked="checked"' else ''
      item = "<input type=\"radio\" name=\"type\" value=\"#{game}\" #{checked}> #{game}<br>"
      gameItems.append item

    $('#myModal').modal 'show'

  select: =>
    games = $('#gameItems input')
    gameTitle = null
    for g, i in games
      if g.checked
        gameTitle = g.value

    @gameGroup.setAttribute 'state', gameTitle + ',' + '2'

    $('#myModal').modal 'hide'
    @changeState State.PLAYING

  cancel: =>
    @changeState State.NOT_STARTED

  changeState: (state) =>
    oldState = @state
    @state = state

    switch state
      when State.NOT_STARTED
        $('#start-button').show()
        $('#cancel-button').hide()

      when State.PLAYING
        $('#start-button').hide()
        $('#cancel-button').show()

  onFinish: (result) =>
    player = result.detail.player
    if player is null
      winner = '引き分け'
    else
      winner = "#{player.name} の勝ち!"

    $('#winner').text winner

    $('#resultModal').modal 'show'

    @changeState State.NOT_STARTED

window.Game = Game

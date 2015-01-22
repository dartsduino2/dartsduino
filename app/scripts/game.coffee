'use strict'

class Game

  State =
    NOT_STARTED: 0
    PLAYING: 1

  KeyCode =
    ENTER: 13
    UP: 38
    DOWN: 40

  state: State.NOT_STARTED
  dartsUi: null
  gameGroup: null

  sound: null

  constructor: ->
    @resizeWindow()
    $(window).resize =>
      @resizeWindow()

    $('#start-button').click @start
    $('#select-button').click @select
    $('#cancel-button').click @cancel

    # $(document.body).keydown =>
    #   if event.keyCode is KeyCode.ENTER
    #     @start()

    @dartsUi = document.querySelector 'darts-ui'
    @dartsUi.addEventListener 'hit', @onHit

    @gameGroup = document.querySelector 'game-group'
    @gameGroup.addEventListener 'finish', @onFinish

    @sound = new Sound()

  onHit: =>
    {point, ratio} = event.detail

    if point is '25'
      # @sound.play 'bull', parseInt(ratio)
      @sound.play 'bull' + parseInt(ratio)
    else
      # @sound.play '1', parseInt(ratio)
      @sound.play ratio

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

  start: =>
    @sound.play 'start2'

    @dartsUi.setAttribute 'focuses', ' '
    @gameGroup.removeAttribute 'state'

    games = (@gameGroup.getAttribute 'games').split ','

    gameItems = $('#gameItems')
    gameItems.empty()

    for game, i in games
      checked = if i is 0 then 'checked="checked"' else ''
      item = $("<input type=\"radio\" name=\"type\" value=\"#{game}\" #{checked}> #{game}<br>")
      item.click =>
        @sound.play 'click'
      gameItems.append item

    $('#myModal').modal 'show'

    selectGame = (index) =>
      $('#gameItems input')[index].checked = true
      @sound.play 'click'

    index = 0
    $('#myModal').keydown (event) =>
      switch event.keyCode
        when KeyCode.ENTER then @select()

        when KeyCode.UP
          index--
          index = games.length - 1 if index < 0
          selectGame index

        when KeyCode.DOWN
          index++
          index = 0 if index >= games.length
          selectGame index

  select: =>
    @sound.play 'start'

    games = $('#gameItems input')
    gameTitle = null
    for g, i in games
      if g.checked
        gameTitle = g.value

    @gameGroup.setAttribute 'state', gameTitle + ',' + '2'

    $('#myModal').modal 'hide'
    @changeState State.PLAYING

  cancel: =>
    @gameGroup.removeAttribute 'state'

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
    if @state isnt State.PLAYING
      return

    if result.detail.message?
      message = result.detail.message
    else
      if result.detail.player?
        message = "#{result.detail.player.name} の勝ち!"
      else
        message = '引き分け'

    $('#message').text message

    $('#resultModal').modal 'show'

    @sound.play 'clap'

    @changeState State.NOT_STARTED

window.Game = Game

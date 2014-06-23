'use strict'

class Game

  State =
    NOT_STARTED: 0
    PLAYING: 1

  state: State.NOT_STARTED

  constructor: ->
    @resizeWindow()
    $(window).resize =>
      @resizeWindow()

    $('#select-button').click @start
    $('#cancel-button').click @cancel

    # game = document.querySelector 'game-501'
    game = document.querySelector 'game-cricket'
    game.setAttribute 'active', ''

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

window.Game = Game

'use strict'

class Game

  constructor: ->
    @resizeWindow()
    $(window).resize =>
      @resizeWindow()

    dartsUi = document.querySelector 'darts-ui'
    dartsUi.addEventListener 'hit', (event) ->
      {score, ratio} = event.detail
      console.log score + ', ' + ratio + ' = ' + score * ratio

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
      .css('margin-left', marginLeft)

window.Game = Game

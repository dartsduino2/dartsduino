'use strict'

class Sound

  SOUND_DIR: 'sounds/'
  SOUNDS:
    '1':
      file: 'dl/hit.ogg'
      # delay: 0.4
    '2':
      file: 'dl/double.ogg'
    '3':
      file: 'dl/triple.ogg'
    'bull1':
      file: 'dl/bull-out.ogg'
      # delay: 0.2
    'bull2':
      file: 'dl/bull-in.ogg'

    'start':
      file: 'dl/start.ogg'
    'click':
      file: 'dl/click.ogg'
    'up':
      file: 'dl/up.ogg'
    'down':
      file: 'dl/down.ogg'
    'great':
      file: 'dl/great.ogg'
    'hiton':
      file: 'dl/hiton.ogg'
    'lowton':
      file: 'dl/lowton.ogg'
    'round':
      file: 'dl/round.ogg'
    'round2':
      file: 'dl/round2.ogg'

    'start2':
      file: '35750_variety-darts-button.wav'
    'clap':
      file: '35656_variety-clap.wav'

  DURATION: 160

  audios: {}

  constructor: ->
    for key, value of @SOUNDS
      @audios[key] = new Audio()
      @audios[key].src = @SOUND_DIR + value.file

  play: (key, repeat) ->
    return unless @audios[key]?

    @doPlay key

    return unless repeat > 1
    repeat--

    timer = setInterval =>
      @doPlay key

      repeat--
      if repeat is 0
        clearInterval timer
    , @DURATION

  doPlay: (key) ->
    clone = @audios[key].cloneNode false

    @audios[key].currentTime = @SOUNDS[key].delay || 0
    @audios[key].play()

    @audios[key] = clone

window.Sound = Sound

'use strict'

class Sound

  SOUND_DIR: 'sounds/'
  SOUNDS:
    '1':
      file: '35782_sword.wav'
      delay: 0.4
    'bull':
      file: '35604_pistol.wav'
      delay: 0.2

  DURATION: 160

  audios: {}

  constructor: ->
    for key, value of @SOUNDS
      @audios[key] = new Audio()
      @audios[key].src = @SOUND_DIR + value.file

  play: (key, repeat) ->
    return unless @audios[key]?

    repeat ||= 1

    @audios[key].currentTime = @SOUNDS[key].delay
    @audios[key].play()

    return if repeat is 1
    repeat--

    timer = setInterval =>
      @audios[key].currentTime = @SOUNDS[key].delay
      @audios[key].play()

      repeat--
      if repeat is 0
        clearInterval timer
    , @DURATION

window.Sound = Sound

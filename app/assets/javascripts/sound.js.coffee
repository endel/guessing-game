class window.Sounds
  constructor: ->
    that = this
    soundManager.setup({
      onready: ->
        that.ready()
    })

  ready: ->
    sound_list = [
      {name: 'buy', url: 'buy-success.mp3'},
      {name: 'combo', url: 'buy-success.mp3'},
      {name: 'answer_correct', url: 'answer-correct.mp3'},
      {name: 'answer_incorrect', url: 'answer-incorrect.mp3'},
      {name: 'cut', url: 'eliminate-two-answers.mp3'},
      {name: 'extra_time', url: 'one-more-time.mp3'},
      {name: 'pass', url: 'pass-the-question.mp3'},
      {name: 'timeout', url: 'timeout.mp3'},
    ]

    console.log("Hello")
    @sounds = {}
    for sound in sound_list
      @sounds[sound.name] = soundManager.createSound({ id: sound.name, url: '/assets/sounds/' + sound.url })
      @sounds[sound.name].load()

  play: (name) ->
    @sounds[name].play()

window.sounds = new window.Sounds()

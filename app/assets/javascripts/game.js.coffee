# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

delay = (ms, func) -> setTimeout func, ms
interval = (ms, func) -> setInterval func, ms

#
# Game
#
class window.Game
  constructor: (data) ->
    that = this
    @options = null
    @last_time = null
    @image_sel = data.image
    @options_sel = data.options_container

    # Controllers
    @user = new Game.User(data.user)
    @countdown = new Game.Countdown({
      game: this,
      container: data.countdown_container
    })
    @helpers = new Game.Helpers({
      game: this,
      container: "#helpers"
    })

    # Bind onclick
    $(@options_sel).on 'click', 'a', (evt) ->
      if (that.countdown.paused)
        return

      that.answer({
        id: $(this).data('id'),
        target: this
      })

  # Request another question
  ask: ->
    that = this

    $.get '/game/ask', (data) ->
      that.build_answers.call(that, data)

  # Build answer list
  build_answers: (data) ->
    @options = new Game.Options(data)

    image_tpl = Handlebars.compile($("#image_tpl").html())
    option_tpl = Handlebars.compile($("#option_tpl").html())

    $(@image_sel).html( image_tpl( @options.answer ) )

    $(@options_sel).html('')
    for option in @options.list
      $(@options_sel).append(option_tpl(option))

    @countdown.start()

  # Answer the question
  answer: (options) ->
    id = options.id
    target = options.target
    that = this

    # Check selected answer
    if (@options.check( $(target).data('id') ))
      $(target).addClass('success')
    else
      # If selected the wrong answer, highlight the right answer
      $(target).addClass('error')
      $(@options_sel + " [data-id="+@options.answer.id+"]").addClass('success')

    @countdown.stop()
    $.post '/game/answer', { time: @countdown.elapsed_time, answer: id }, (data) ->
      delay 1000, ->
        that.build_answers.call(that, data)

#
# Game.User
#
class Game.User
  constructor: (data) ->
    @data = data
    @helper = data.helpers

#
# Game.Options
#
class Game.Options
  constructor: (data) ->
    @answer = data.answer
    @list = data.options.shuffle()

  check: (id) ->
    @answer.id == id

#
# Game.Helpers class
#
class Game.Helpers
  constructor: (data) ->
    @game = data.game
    @consumed = []

    that = this
    $(data.container).on 'click', '#cut', ->
      if that.game.user.helper['cut'] > 0
        that.game.user.helper['cut'] -= 1
        that.consume(Game.Helpers.Cut)

    $(data.container).on 'click', '#extra_time', ->
      if that.game.user.helper['extra_time'] > 0
        that.game.user.helper['extra_time'] -= 1
        that.consume(Game.Helpers.ExtraTime)

    $(data.container).on 'click', '#pass', ->
      if that.game.user.helper['pass'] > 0
        that.game.user.helper['pass'] -= 1
        that.consume(Game.Helpers.Pass)

  consume: (klass) ->
    helper = new klass()
    @consumed.push helper.use(@game)

#
# Game.Helpers.Cut
#
class Game.Helpers.Cut
  name: "cut"
  use: (game) ->
    # Get list of ids
    game.options.list.filter (option) ->
      console.log(option)

    $(game.options_sel + "[data-id!="+game.options.answer.id+"]")

    this.name

#
# Game.Helpers.ExtraTime
#
class Game.Helpers.ExtraTime
  name: "extra_time"
  use: (game) ->
    this.name

#
# Game.Helpers.Pass
#
class Game.Helpers.Pass
  name: "pass"
  use: (game) ->
    this.name

#
# Game.Helpers.Countdown
#
class Game.Countdown
  constructor: (data) ->
    @game = data.game
    @container = data.container
    @interval = null
    @paused = true
    @timer = null
    @elapsed_time = null

  start: ->
    @paused = false
    @counter = 10
    that = this
    this.update()

    @interval = interval 1000, ->
      that.update()

  stop: ->
    clearInterval @interval
    @paused = true
    @elapsed_time = (new Date()) - @timer

  update: ->
    @timer = new Date()

    if (@counter < 0)
      this.stop()
      @game.ask()
    else
      $(@container).html(@counter)
      @counter -= 1

#
# Game.Scorer
#
class Game.Scorer
  constructor: (countdown) ->
    @countdown = countdown

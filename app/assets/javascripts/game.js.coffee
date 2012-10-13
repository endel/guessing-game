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
    @specials = new Game.Specials({
      game: this,
      container: "#specials"
    })

    # Bind onclick
    $(@options_sel).on 'click', 'a', (evt) ->
      if (that.countdown.paused)
        return

      that.answer({
        id: $(this).data('id'),
        target: this
      })
      false

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
    @special = data.specials

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
# Game.Specials class
#
class Game.Specials
  constructor: (data) ->
    @game = data.game
    @consumed = []

    that = this
    $(data.container).on 'click', '#cut', ->
      that.try_consume(Game.Specials.Cut)
      false

    $(data.container).on 'click', '#extra_time', ->
      that.try_consume(Game.Specials.ExtraTime)
      false

    $(data.container).on 'click', '#pass', ->
      that.try_consume(Game.Specials.Pass)
      false

  try_consume: (klass) ->
    special = new klass()
    if @game.user.special[special.name] > 0
      @game.user.special[special.name] -= 1
      @consumed.push special.use(@game)

#
# Common Special Class
#
class Game.Specials.Base
  constructor: ->
    @element = $("#" + this.name)

#
# Game.Specials.Cut
#
class Game.Specials.Cut extends Game.Specials.Base
  name: "cut"
  use: (game) ->
    # Get list of wrong answers that isn't disabled
    avaible_wrong_answers = []
    $(game.options_sel + " [data-id!='"+game.options.answer.id+"']:not(.disabled)").map (i) ->
      avaible_wrong_answers.push($(this).data('id'))

    # Shuffle wrong answers list
    avaible_wrong_answers.shuffle()

    $(game.options_sel + " [data-id="+avaible_wrong_answers.shift()+"]").addClass('disabled')
    $(game.options_sel + " [data-id="+avaible_wrong_answers.shift()+"]").addClass('disabled')

    this.name

#
# Game.Specials.ExtraTime
#
class Game.Specials.ExtraTime extends Game.Specials.Base
  name: "extra_time"
  use: (game) ->
    this.name

#
# Game.Specials.Pass
#
class Game.Specials.Pass extends Game.Specials.Base
  name: "pass"
  use: (game) ->
    this.name

#
# Game.Specials.Countdown
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
    $(@container).removeClass('counter-' + (@counter + 1))

    if (@counter < 0)
      this.stop()
      @game.ask()
    else
      $(@container).addClass('counter-' + @counter)
      $(@container).html(@counter)
      @counter -= 1

#
# Game.Scorer
#
class Game.Scorer
  constructor: (countdown) ->
    @countdown = countdown

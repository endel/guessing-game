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
    @message_sel = data.message
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

    @transitioner = new Game.Transitioner()
    @scorer = new Game.Scorer({
      container: '#score-container'
    })

    @message_builder = new Game.MessageBuilder()

    # Bind onclick
    $(@options_sel).on 'click', 'a', (evt) ->
      if (that.countdown.paused || $(this).hasClass('disabled'))
        return false

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
    @specials.restart()
    @options = new Game.Options(data)

    image_tpl = Handlebars.compile($("#image_tpl").html())
    option_tpl = Handlebars.compile($("#option_tpl").html())

    # Fade in / rotate / show image
    $(@message_sel).addClass('fadeOut').removeClass('rotated')

    $(@image_sel).parent().removeClass('rotated')
    $(@image_sel).removeClass('rotated').
      removeClass('fadeOut').
      addClass('fadeIn').
      html( image_tpl( @options.answer ) )

    $(@options_sel).html('')
    for option in @options.list
      $(@options_sel).prepend(option_tpl(option))

    @countdown.start()

  # Show message and update score UI
  show_message: (data) ->
    # Preload next image
    img = new Image()
    img.src = data.answer.url

    # Update score UI
    @scorer.update( parseInt(data.score) )

    # Fade out / rotate / show message
    $(@image_sel).addClass('rotated').addClass('fadeOut')
    message = @message_builder.build(data.message_type, $.extend(data, {
      total_score: @scorer.score
    }))
    $(@message_sel).html(message).removeClass('fadeOut').addClass('rotated').addClass('fadeIn')

  # Answer the question
  answer: (options) ->
    id = options.id
    target = options.target
    that = this
    message_type = null

    # Add success/error class to target, if it was set
    if target
      # Check selected answer
      if (@options.check( $(target).data('id') ))
        # Play "answer correct"
        sounds.play('answer_correct')
        message_type = 'success'
        $(target).addClass('success')
      else
        # If selected the wrong answer, highlight the right answer
        sounds.play('answer_incorrect')
        message_type = 'error'
        $(target).addClass('error')
        $(@options_sel + " [data-id="+@options.answer.id+"]").addClass('success')
    else
      # Timeout... (only if 'pass' special isn't used)
      unless $.inArray("pass", @specials.consumed) >= 0
        message_type = 'timeout'
        sounds.play('timeout')

    @countdown.stop()
    $.post '/game/answer', { time: @countdown.elapsed_time, answer_id: id,  matter_id: @options.answer.matter_id, specials:  @specials.consumed }, (data) ->
      data.message_type = message_type
      that.show_message(data)
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
    @specials = {}
    that = this
    this.restart()

    specials = [ Game.Specials.Cut, Game.Specials.ExtraTime, Game.Specials.Pass ]

    for special_class in specials
      special = new special_class(@game)
      @specials[special.name] = special

      # Immediatelly update user interface
      @specials[special.name].update_ui()

      # Bind click event for each special
      $(data.container + " #" + special.name).data('name', special.name)
      $(data.container).on 'click', '#' + special.name, ->
        that.try_consume($(this).data('name'))
        false

  try_consume: (special) ->
    if @game.user.special[special] > 0
      @game.user.special[special] -= 1
      @specials[special].update_ui()

      @consumed.push(special)
      @specials[special].use(@game)

  restart: ->
    @consumed = []

#
# Common Special Class
#
class Game.Specials.Base
  constructor: (game) ->
    @game = game
    @element = $("#" + this.name)

  # Update User Interface
  update_ui: ->
    $('#' + this.name + " span").html( @game.user.special[this.name] )
    if (@game.user.special[this.name] <= 0)
      $('#' + this.name).addClass('disabled')

#
# Game.Specials.Cut
#
class Game.Specials.Cut extends Game.Specials.Base
  name: "cut"
  use: (game) ->
    sounds.play('cut')

    # Get list of wrong answers that isn't disabled
    avaible_wrong_answers = []
    $(game.options_sel + " [data-id!='"+game.options.answer.id+"']:not(.disabled)").map (i) ->
      avaible_wrong_answers.push($(this).data('id'))

    # Shuffle wrong answers list
    avaible_wrong_answers.shuffle()

    $(game.options_sel + " [data-id="+avaible_wrong_answers.shift()+"]").addClass('disabled') # .parent().unbind('click')
    $(game.options_sel + " [data-id="+avaible_wrong_answers.shift()+"]").addClass('disabled') # .parent().unbind('click')

#
# Game.Specials.ExtraTime
#
class Game.Specials.ExtraTime extends Game.Specials.Base
  name: "extra_time"
  use: (game) ->
    sounds.play('extra_time')
    game.countdown.counter += 11
    game.countdown.update()

#
# Game.Specials.Pass
#
class Game.Specials.Pass extends Game.Specials.Base
  name: "pass"
  use: (game) ->
    # Your answer is correct!
    sounds.play('pass')
    game.answer({
      id: game.options.answer.id,
      target: null
    })

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
    @counter = 15
    @timer = new Date()
    that = this
    this.update()

    @interval = interval 1000, ->
      that.update()

  stop: ->
    clearInterval @interval
    @paused = true
    @elapsed_time = (new Date()) - @timer

  update: ->
    $(@container).parent().removeClass('counter-' + (@counter + 1))

    if (@counter < 0)
      this.stop()

      # Get first wrong answer
      wrong_answers = []
      for option in @game.options.list
        if option.id != @game.options.answer.id
          return @game.answer({id: wrong_answers[0], target: null})

    else
      $(@container).parent().addClass('counter-' + @counter)
      $(@container).html(@counter)
      @counter -= 1

class Game.Transitioner
  constructor: (game) ->
    @game = game

#
# Game.Scorer
#
class Game.Scorer
  constructor: (data) ->
    @score = 0
    @questions = 0
    @container = data.container

    # Ticks
    @tick_interval = null
    @score_tmp = 0
    @backwards = false
  update: (add_score) ->
    @questions += 1
    @score_tmp = @score
    @score += add_score
    @backwards = (add_score < 0)

    if add_score != 0
      # Keep ticking +1 until it shows the actual score
      that = this
      @tick_interval = interval 1, ->
        that.quick_tick()

      # Bounce effect
      $(@container).addClass('bounceIn')
      delay 2000, ->
        $("#score-container").removeClass('bounceIn')

  quick_tick: ->
    if (@score_tmp != @score)
      if @backwards
        @score_tmp -= 1
      else
        @score_tmp += 1
      $(@container + " span").html( @score_tmp )
    else
      clearInterval @tick_interval

class Game.MessageBuilder
  constructor: ->
    @tpl = Handlebars.compile($('#message').html())
    @types = {
      error: {
        type: 'error',
        image_src: '/assets/messages/error.png',
        title: 'You missed.',
        message: '<p>Keep trying images that will appear in the next.</p>',
      },
      end: {
        type: 'end',
        image_src: '/assets/messages/end.png',
        title: 'His round ended.',
        message: '<p>You got {{total_score}} points, hitting <strong>{{success}}</strong> of 20 questions. <br/><a href="/rankings/summary">Check out how your ranking.</a></p>',
      },
      success: {
        type: 'success',
        image_src: '/assets/messages/success.png',
        title: "That's it!",
        message: '<p>Try to respond even faster to gain more points walks.</p>',
      },
      timeout: {
        type: 'timeout',
        image_src: '/assets/messages/timeout.png',
        title: 'Time is up!',
        message: '<p>Take care in the next time!</p>',
      },
    }
  build: (type, replacements) ->
    object = @types[type]
    for replacement in replacements
      console.log(replacement)
      object.message = object.message.replace(  )

    @tpl(object)


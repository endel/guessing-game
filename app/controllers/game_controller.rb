class GameController < ApplicationController
  before_filter :prevent_cache, :only => [:ask, :answer]

  # GET
  def index
    render :layout => 'login'
    redirect_to :action => :play if @user.present?
  end

  # GET
  def ranking

  end

  # GET
  def play

  end

  # GET
  def ask
    # Time is up! No scoring and get another question.
    if params['timeout']
    end

    @category = Category.order("RANDOM()").first
    @options = @category.pictures.order("RANDOM()").limit(6).to_a
    @answer = @options.first
    session['answer'] = @answer.id

    #
    # TODO: encode with JSON for security
    #
    # require "base64"
    # Base64.encode64({:picture => @picture, :options => @options.collect {|x| x.name }}.to_json)
    render :json => {:answer => @answer, :options => @options.as_json(:tiny => true)}
  end

  # POST
  def answer
    puts "lalalalalala: #{session['answer']} / #{params['answer']}"
    if session['answer'].to_s == params['answer']
      puts 'PURURUCA'
      # Time in miliseconds
      @user.score += (10000 - params['time'].to_i) / 100 # Best score is 100 points per hit


      @user.save
      # SCORE
      #
    end

    redirect_to :action => :ask
  end

end

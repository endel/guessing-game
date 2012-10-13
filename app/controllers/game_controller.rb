class GameController < ApplicationController
  before_filter :prevent_cache, :only => [:ask, :answer]

  # GET
  def index
    @matters = Matter.all
    render :layout => 'login' unless @user.present?
  end

  # GET
  def ranking

  end

  # GET
  def play
    @matters = Matter.where(:id => params[:matters])
    session[:matters] = @matters.collect {|x| x.id }
  end

  # GET
  def ask
    # Time is up! No scoring and get another question.
    if params['timeout']
    end

    category_matter_id = {}
    category_ids = Matter.where(:id => session[:matters]).collect do |x|
      categories = x.categories.split(",")
      categories.each {|category_id| category_matter_id[category_id.to_i] = x.id }
      categories
    end

    @category = Category.where(:id => category_ids).order(db_rand_func).first
    @options = @category.pictures.order(db_rand_func).limit(6).to_a
    @answer = @options.first.as_json.merge(:matter_id => category_matter_id[ @category.id ])
    session['answer'] = @answer[:id]

    #
    # TODO: encode with JSON for security
    #
    # require "base64"
    # Base64.encode64({:picture => @picture, :options => @options.collect {|x| x.name }}.to_json)
    render :json => {:user => @user.as_json, :answer => @answer, :options => @options.as_json(:tiny => true)}
  end

  # POST
  def answer
    if session['answer'].to_s == params['answer']
      # Time in miliseconds
      @user.score += (10000 - params['time'].to_i) / 100 # Best score is 100 points per hit


      @user.save
    end

    redirect_to :action => :ask
  end

  protected
    def db_rand_func
      (Rails.env.production?) ? 'RAND()' : 'RANDOM()'
    end
end

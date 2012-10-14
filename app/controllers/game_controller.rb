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
    unless params[:matters].present? && params[:matters].length > 0
      flash[:message] = 'category-required'
      redirect_to :action => :index
    end
    @matters = Matter.where(:id => params[:matters])
    session[:matters] = @matters.collect {|x| x.id }
  end

  # GET
  def ask
    category_matter_id = {}
    category_ids = Matter.where(:id => session[:matters]).collect do |x|
      categories = x.categories.split(",")
      categories.each {|category_id| category_matter_id[category_id.to_i] = x.id }
      categories
    end

    @category = Category.where(:id => category_ids).order(db_rand_func).first
    @options = @category.pictures.order(db_rand_func).limit(6).to_a
    @answer = @options.first.as_json.merge(:matter_id => category_matter_id[ @category.id ])
    session['answer_id'] = @answer[:id]

    puts params.inspect

    #
    # TODO: encode with JSON for security
    #
    # require "base64"
    # Base64.encode64({:picture => @picture, :options => @options.collect {|x| x.name }}.to_json)
    render :json => {:score => params[:score] || 0, :user => @user.as_json, :answer => @answer, :options => @options.as_json(:tiny => true)}
  end

  # POST
  def answer
    score = 0

    # Decrease each special used on this answer
    time_qty = 1
    if params['specials']
      puts "specials -> #{params['specials'].inspect}"
      specials = {}
      params['specials'].each do |special|
        time_qty += 1 if special == "extra_time"

        special_id = SPECIAL.const_get(special.upcase)
        puts "special_id.inspect => #{special_id.inspect}"
        specials[ special_id ] = @user.user_specials.where(:special_id => special_id).first unless specials[ special_id ]
        specials[ special_id ].qtt -= 1
      end
      specials.each_value {|special| puts "saved? => #{special.save.inspect}" }
    end

    # Is the answer correct?
    correct = (session['answer_id'].to_s == params['answer_id'])

    # Best score is 100 points per hit
    score = ((15000*time_qty) / (params['time'].to_f / 10)) if correct

    # Multiply score by combo parameter
    score *= (params['combo'] || 0).to_i + 1

    @user.score += score
    @user.save

    ranking = @user.rankings.where("matter_id = ? AND week_date = ?", params[:matter_id], Time.now.at_beginning_of_week.strftime("%Y-%m-%d")).first
    if ranking.nil?
      @user.rankings.create(:matter_id => params[:matter_id], :week_date => Time.now.at_beginning_of_week, :total_score => score)
    else
      ranking.total_score += score
      ranking.save
    end

    redirect_to :action => :ask, :score => score
  end

  protected
    def db_rand_func
      (Rails.env.production?) ? 'RAND()' : 'RANDOM()'
    end
end

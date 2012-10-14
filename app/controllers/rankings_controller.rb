class RankingsController < ApplicationController

  def index
  end

  def weekly
    @ranking = Ranking.all_matter_weekly(Time.now.at_beginning_of_week.strftime('%Y-%m-%d'))

    respond_to do |format|
      format.html { render 'index' }
      format.json { render json: @ranking }
    end
  end

  def monthly
    @ranking = Ranking.monthly

    respond_to do |format|
      format.html { render 'index' }
      format.json { render json: @ranking }
    end
  end

  def summary
    @ranking = Ranking.summary(@user)

    respond_to do |format|
      format.html { render 'index' }
      format.json { render json: @ranking }
    end
  end

end

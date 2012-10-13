class RankingsController < ApplicationController
  
  def weekly
    @ranking = Ranking.weekly   
    
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
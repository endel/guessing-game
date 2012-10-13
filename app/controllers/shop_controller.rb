class ShopController < ApplicationController
  
  def index
    @helpers = Helper.all
  end
  
  # POST
  def buy
    helper = Helper.find(params[:helper][:id])
    
    respond_to do |format|
      if @user.buy(helper, params[:helper][:qtt])
        format.html# { text: "You bought!" }
        format.json { render :json => { :message => "You bought #{params[:helper][:qtt]} of #{helper.name}!"}}   
      else
        format.html# { text: "Insuficient money!" }
        format.json { render :json => { :message => "Insuficient money!"}}   
      end
    end
    
  end
  
end
class ShopController < ApplicationController
  
  def index
    @helpers = Helper.all
  end
  
  # POST
  def buy
    cart = params[:available_helpers].select {|v,k| v[k].present? }
    total = 0
    cart.each {|v,k| total += Helper.find(v).price.to_i }

    # Verify if the user has money to buy all items
    if @user.coins >= total
      # Buy the helpers selected
      cart.each do |h|
        helper = Helper.find(h.first)
        @user.buy(helper, h[1] ||= 0)
      end
      render :json => { :message => "You bought!" }
    else
      render :json => { :message => "Inusificient cash!" }
    end

  end
  
end
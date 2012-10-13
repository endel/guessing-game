class ShopController < ApplicationController
  
  def index
    @specials = Special.all
  end
  
  # POST
  def buy
    cart = params[:available_specials].select {|key, value| params[:available_specials][key].present? }
    total = 0
    cart.each {|v,k| total += (Special.find(v).price.to_i * k.to_i) }
    puts "CART=>#{cart.inspect} - TOTAL=>#{total}"
    
    # Verify if the user has money to buy all items
    if @user.coins >= total
      # Buy the selected helpers
      cart.each do |s|
        
        special = Special.find(s.first)
        puts "Buying=>#{special.name}"
        @user.buy(special, s[1] ||= 0)
      end
      render :json => { :message => "You bought!" }
    else
      render :json => { :message => "Inusificient cash!" }
    end

  end
  
end
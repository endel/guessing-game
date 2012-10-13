class UserController < ApplicationController
  def index
  end

  def login
    if @user.present?
      redirect_to :action => :play
    else
      render :layout => 'login'
    end
  end

  def profile
  end
end

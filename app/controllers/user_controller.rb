class UserController < ApplicationController
  def index
  end

  def login
    if @user.present?
      redirect_to game_path
    else
      render :layout => 'login'
    end
  end

  def show
    @profile = User.find(params[:id])
  end

  def search
    q = "%#{params['search']}%"
    @profiles = User.where("name LIKE ? OR nickname LIKE ?", q, q)
  end
end

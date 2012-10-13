class SessionsController < ApplicationController
  before_filter :skip_authentication

  def new
  end

  def create
    auth_hash = request.env['omniauth.auth']

    @authorization = Authorization.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
    if @authorization
      session[:user_id] = @authorization.user.id
    else
      user = User.new({
        :name => auth_hash['info']['name'],
        :image => auth_hash['info']['image'],
        :email => auth_hash['info']['email'],
        :nickname => auth_hash['info']['nickname'],
        :locale => auth_hash['extra']['raw_info']['locale'],
        :timezone => auth_hash['extra']['raw_info']['timezone']
      })
      user.authorizations.build :provider => auth_hash["provider"], :uid => auth_hash["uid"]
      user.save

      session[:user_id] = user.id
    end

    redirect_to game_path
  end

  def failure
    flash[:error] = true
    render :new
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

  protected

    def skip_authentication
      redirect_to stories_path if @user.present?
    end

end


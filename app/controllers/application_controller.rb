class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :load_context!

  module SPECIAL
    CUT = (x = Special.find_by_identifier("cut") && c.id)
    PASS = (x = Special.find_by_identifier("pass") && x.id)
    EXTRA_TIME = (x = Special.find_by_identifier("extra_time") && x.id)
  end

  #
  # Load author context
  #
  def load_context!
    session[:user_id] = User.first.id if Rails.env.development?
    return unless session[:user_id]

    @user = User.find(session[:user_id])
  end

  def prevent_cache
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

end


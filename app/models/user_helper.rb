class UserHelper < ActiveRecord::Base
  attr_accessible :helper_id, :user_id, :name, :qtt

  belongs_to :user
  belongs_to :helper
end

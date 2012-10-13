class UserSpecial < ActiveRecord::Base
  attr_accessible :special_id, :user_id, :qtt

  belongs_to :user
  belongs_to :special
end

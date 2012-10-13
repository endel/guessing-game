class UserSpecial < ActiveRecord::Base
  attr_accessible :special_id, :user_id, :name, :qtt

  belongs_to :user
  belongs_to :special
end

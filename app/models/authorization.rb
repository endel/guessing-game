class Authorization < ActiveRecord::Base
  attr_accessible :provider, :uid
  belongs_to :user

  validates :provider, :uid, :presence => true
end

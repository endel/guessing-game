class Helper < ActiveRecord::Base
  has_many :users, :through => :user_helpers
  attr_accessible :price, :identifier

end

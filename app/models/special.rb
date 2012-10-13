class Special < ActiveRecord::Base
  has_many :users, :through => :user_helpers
  attr_accessible :price, :identifier, :name

end

class Special < ActiveRecord::Base
  has_many :users, :through => :user_helpers
  attr_accessible :name, :price, :identifier

  def sell(user)
  end

end

class Matter < ActiveRecord::Base
  attr_accessible :categories, :name
  has_many :rankings
end

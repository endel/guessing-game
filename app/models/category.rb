class Category < ActiveRecord::Base
  has_many :picture_categories
  has_many :pictures,  :through => :picture_categories
  attr_accessible :name, :status
end

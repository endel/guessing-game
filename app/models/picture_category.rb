class PictureCategory < ActiveRecord::Base
  belongs_to :category
  belongs_to :picture
  # attr_accessible :title, :body
end

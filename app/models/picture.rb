class Picture < ActiveRecord::Base
  #has_and_belongs_to_many :categories
  attr_accessible :name, :status, :url, :category_id

  def as_json(options={})
    tiny = options[:tiny]
    attributes =  {
      :id => self.id,
      :name => self.name
    }
    attributes[:url] = self.url unless tiny
    attributes
  end
end

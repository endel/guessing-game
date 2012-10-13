class User < ActiveRecord::Base
  attr_accessible :email, :name, :score, :nickname, :image, :coins
  has_many :authorizations

  has_many :user_helpers
  has_many :helpers, :through => :user_helpers

  validates :name, :email, :presence => true

  def buy(helper, qtt)
    # if the user has sufficient coins to buy, let`s sell
    if self.coins >= (helper.price * qtt.to_i)
      self.user_helpers.create(:helper => helper, :qtt => qtt)
      true
    else
      false
    end
  end

  def as_json(*args)
    puts self.helpers.inspect
    self.attributes.merge({
      :helpers => Hash[self.user_helpers.collect {|uh| [uh.helper.identifier, uh.qtt] }]
    })
  end

end


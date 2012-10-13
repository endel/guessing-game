class User < ActiveRecord::Base
  attr_accessible :email, :name, :score, :nickname, :image, :coins
  has_many :authorizations

  has_many :user_specials
  has_many :specials, :through => :user_specials

  validates :name, :email, :presence => true

  def buy(special, qtt)
    # if the user has sufficient coins to buy, let`s sell
    if self.coins >= (special.price * qtt.to_i)

      self.user_specials.where(:special => special).size == 0 ?
      self.user_specials.create(:special => special, :qtt => qtt) :
      self.user_specials.where(:special => special).first.update_attributes(:qtt => qtt)

      true
    else
      false
    end
  end
  def as_json(*args)
    puts self.specials.inspect
    self.attributes.merge({
      :specials => Hash[self.user_specials.collect {|uh| [uh.special.identifier, uh.qtt] }]
    })
  end

end


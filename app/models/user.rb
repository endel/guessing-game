class User < ActiveRecord::Base
  attr_accessible :email, :name, :score, :nickname, :image, :coins,
                  :locale, :timezone
  has_many :authorizations

  has_many :user_specials
  has_many :specials, :through => :user_specials

  validates :name, :email, :presence => true
  has_many :rankings

  before_create :setup_specials!

  def buy(special, qtt)
    # Implement a nested transaction here

    # if the user has sufficient coins to buy, let`s sell
    if self.coins >= (special.price * qtt.to_i)

      if self.user_specials.where(:special_id => special.id).size == 0
        self.user_specials.create(:special_id => special.id, :qtt => qtt)
      else
        user_special = self.user_specials.where(:special_id => special.id).first
        user_special.update_attributes(:qtt => (user_special.qtt.to_i + qtt.to_i))
      end

      self.coins = self.coins - (special.price * qtt.to_i)
      self.save
    end

  end

  # Setup initial user specials
  def setup_specials!
    self.user_specials.build([
      {:special_id => ApplicationController::SPECIAL::CUT, :qtt => 5},
      {:special_id => ApplicationController::SPECIAL::EXTRA_TIME, :qtt => 10},
      {:special_id => ApplicationController::SPECIAL::PASS, :qtt => 3}
    ])
  end

  def as_json(*args)
    self.attributes.merge({
      :specials => Hash[self.user_specials.collect {|uh| [uh.special.identifier, uh.qtt] }]
    })
  end

end


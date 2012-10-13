class User < ActiveRecord::Base
  attr_accessible :email, :name, :score, :nickname, :image, :coins,
                  :locale, :timezone
  has_many :authorizations

  has_many :user_specials
  has_many :specials, :through => :user_specials

  validates :name, :email, :presence => true

  def buy(helper, qtt)
    # Implement a nested transaction here

      # if the user has sufficient coins to buy, let`s sell
      if self.coins >= (helper.price * qtt.to_i)

        if self.user_helpers.where(:helper_id => helper.id).size == 0
          self.user_helpers.create(:helper_id => helper.id, :qtt => qtt)
        else
          user_helper = self.user_helpers.where(:helper_id => helper.id).first
          user_helper.update_attributes(:qtt => (user_helper.qtt.to_i + qtt.to_i))
        end

        self.coins = self.coins - (helper.price * qtt.to_i)
        self.save
      end

  end
  def as_json(*args)
    puts self.specials.inspect
    self.attributes.merge({
      :specials => Hash[self.user_specials.collect {|uh| [uh.special.identifier, uh.qtt] }]
    })
  end

end


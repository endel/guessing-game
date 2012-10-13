class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :nickname
      t.string :image
      t.integer :score,   :default => 0
      t.string :locale
      t.integer :timezone
      t.integer :coins,     :default => 0

      t.timestamps
    end
  end
end


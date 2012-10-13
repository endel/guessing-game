class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :nickname
      t.string :image
      t.float :score,     :default => 0
      t.string :locale
      t.integer :timezone

      t.timestamps
    end
  end
end


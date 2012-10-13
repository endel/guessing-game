class CreateUserSpecials < ActiveRecord::Migration
  def change
    create_table :user_specials do |t|
      t.references :user
      t.references :special
      t.string :name
      t.integer :qtt

      t.timestamps
    end
    add_index :user_specials, :user_id
    add_index :user_specials, :special_id
  end
end


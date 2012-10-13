class CreateUserHelpers < ActiveRecord::Migration
  def change
    create_table :user_helpers do |t|
      t.references :user
      t.references :helper
      t.string :name
      t.integer :qtt

      t.timestamps
    end
    add_index :user_helpers, :user_id
    add_index :user_helpers, :helper_id
  end
end


class AddCoinsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :coins, :float, :default => 0
  end
end

class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.belongs_to :user
      t.integer :score
      t.datetime :week_date
    end
    add_index :rankings, :user_id
  end
end

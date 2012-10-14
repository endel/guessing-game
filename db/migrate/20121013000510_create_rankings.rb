class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.belongs_to :user
      t.integer :total_score
      t.date :week_date
    end
    add_index :rankings, :user_id
  end
end

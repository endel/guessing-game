class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.belongs_to :user
      t.float :score

      t.timestamps
    end
    add_index :rankings, :user_id
  end
end

class AddMatterIdToRanking < ActiveRecord::Migration
  def change
    add_column :rankings, :matter_id, :integer
  end
end

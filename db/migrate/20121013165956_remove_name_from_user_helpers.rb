class RemoveNameFromUserHelpers < ActiveRecord::Migration
  def up
    remove_column :user_helpers, :name
  end

  def down
  end
end

class CreatePictureCategories < ActiveRecord::Migration
  def change
    create_table :picture_categories do |t|
      t.references :category
      t.references :picture

      t.timestamps
    end
    add_index :picture_categories, :category_id
    add_index :picture_categories, :picture_id
  end
end

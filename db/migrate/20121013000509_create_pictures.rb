class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :name
      t.string :url
      t.belongs_to :category
      t.boolean :status

      t.timestamps
    end
    add_index :pictures, :category_id
  end
end

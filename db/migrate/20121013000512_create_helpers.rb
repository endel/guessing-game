class CreateHelpers < ActiveRecord::Migration
  def change
    create_table :helpers do |t|
      t.string :name
      t.integer :price
      t.string :identifier

      t.timestamps
    end
  end
end

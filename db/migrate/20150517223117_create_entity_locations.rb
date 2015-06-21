class CreateEntityLocations < ActiveRecord::Migration
  def change
    create_table :entity_locations do |t|
      t.belongs_to :entity
      t.belongs_to :map
      t.integer :location_y
      t.integer :location_x
      t.integer :direction
      t.timestamps null: false
    end
  end
end

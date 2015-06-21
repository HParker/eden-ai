class CreateEntities < ActiveRecord::Migration
  def change
    create_table :entities do |t|
      t.string :name
      t.string :sprite
      t.string :char
      t.timestamps null: false
    end
  end
end

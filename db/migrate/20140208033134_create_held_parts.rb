class CreateHeldParts < ActiveRecord::Migration
  def change
    create_table :held_parts do |t|
      t.integer :quantity
      t.decimal :core_cost
      t.decimal :price

      t.timestamps
    end
  end
end

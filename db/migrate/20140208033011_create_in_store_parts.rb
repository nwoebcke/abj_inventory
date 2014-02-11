class CreateInStoreParts < ActiveRecord::Migration
  def change
    create_table :in_store_parts do |t|
      t.integer :on_hand
      t.integer :max
      t.integer :min

      t.timestamps
    end
  end
end

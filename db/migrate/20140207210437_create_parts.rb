class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.string :product_line
      t.string :part_num, :null => false
      t.string :description, :default => ""
      t.decimal :price0, :precision => 10, :scale => 2
      t.decimal :price1, :precision => 10, :scale => 2
      t.decimal :price2, :precision => 10, :scale => 2
      t.decimal :price3, :precision => 10, :scale => 2
      t.decimal :price4, :precision => 10, :scale => 2
      t.decimal :price5, :precision => 10, :scale => 2
      t.timestamps
    end
    add_index :parts, [:product_line, :part_num]
    add_index :parts, :part_num
  end
end

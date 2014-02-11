class PartsFromPrices < ActiveRecord::Migration
  def up
    create_table :parts_from_prices do |t|
      t.references :product_line
      t.string :part_num, :null => false
      t.decimal :price0, :precision => 10, :scale => 2
      t.decimal :price1, :precision => 10, :scale => 2
      t.decimal :price2, :precision => 10, :scale => 2
      t.decimal :price3, :precision => 10, :scale => 2
      t.decimal :price4, :precision => 10, :scale => 2
      t.decimal :price5, :precision => 10, :scale => 2
    end
    add_index :parts_from_prices, :part_num
  end

  def down
    remove_index :parts_from_prices, :part_num
    drop_table :parts_from_prices
  end
end

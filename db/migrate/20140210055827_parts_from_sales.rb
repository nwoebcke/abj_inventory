class PartsFromSales < ActiveRecord::Migration
  def up
    create_table :parts_from_sales do |t|
  		t.references :product_line
  		t.string :part_num, :limit => 20, :null => false
      t.string :description, :default => ""
		  t.timestamps
  	end
  	add_index :parts_from_sales, :part_num
  end

  def down
    remove_index :parts_from_sales, :part_num
    drop table :parts_from_sales
  end
end

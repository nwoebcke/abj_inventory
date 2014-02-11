class CreateCustomerProductLines < ActiveRecord::Migration
  def up
    create_table :customer_product_lines do |t|
    	t.references :customer, :null => false
    	t.references :product_line, :null => false
    	t.string :name, :limit => 25, :null =>false
      	t.timestamps
    end
    add_index :customer_product_lines, [:customer_id, :product_line_id]
  end

  def down
  	remove_index :customer_product_lines, [:customer_id, :product_line_id]
  	drop_table :customer_product_lines
  end
end

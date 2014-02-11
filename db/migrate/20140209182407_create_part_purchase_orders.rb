class CreatePartPurchaseOrders < ActiveRecord::Migration
  def up
    create_table :part_purchase_orders do |t|
  		t.references :part
  		t.references :purchase_order
  		t.datetime :date_counted
  		t.integer :count_qty
		t.timestamps
  	end
  	add_index :part_purchase_orders, [:part_id, :purchase_order_id]
  end

  def down
  	remove_index :part_purchase_orders, [:part_id, :purchase_order_id]
  	drop_table :part_purchase_orders
  end
end

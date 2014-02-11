class AddCustomerRefToPos < ActiveRecord::Migration
  def up
  	add_column :purchase_orders, :customer_id, :integer
  end
  def down
  	remove_column :purchase_orders, :customer_id
  end
end

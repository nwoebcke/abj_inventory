class CreatePurchaseOrders < ActiveRecord::Migration
  def change
    create_table :purchase_orders do |t|
      t.datetime :order_date, :null => true
      t.datetime :delivery_date, :null => true
      t.string :po_num, :default => "", :limit => 15
      t.boolean :is_open, :default => true

      t.timestamps
    end
  end
end

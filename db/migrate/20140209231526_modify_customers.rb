class ModifyCustomers < ActiveRecord::Migration
  def up
  	add_column :customers, :old_id, :integer, :null => false
	change_column :customers, :name, :string, :limit => 40, :null => false
	change_column :customers, :address, :string, :limit => 40, :null => true
	change_column :customers, :city, :string, :limit => 40, :null => true
	change_column :customers, :state, :string, :limit => 40, :null => true
	change_column :customers, :zip, :string, :limit => 20, :null => true
	change_column :customers, :phone, :string, :limit => 40, :null => true
	add_column :customers, :fax, :string, :limit => 40, :null => true
	change_column :customers, :email, :string, :limit => 40, :null => true
	add_index :customers, :name
  end

  def down
	remove_index :customers, :name
	change_column :customers, :name, :string, :limit => nil, :null => true
	change_column :customers, :address, :string, :limit => nil
	change_column :customers, :city, :string, :limit => nil
	change_column :customers, :state, :string, :limit => nil
	change_column :customers, :zip, :string, :limit => nil
	change_column :customers, :phone, :string, :limit => nil
	remove_column :customers, :fax
	change_column :customers, :email, :string, :limit => nil
	remove_column :customers, :old_id
  end
end

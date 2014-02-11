class ModifyPartProdLines < ActiveRecord::Migration
  def up
  	rename_column :parts, :product_line, :product_line_id
  	change_column :parts, :product_line_id, :integer
  	add_column :product_lines, :old_id, :integer
  end

  def down
  	rename_column :parts, :product_line_id, :product_line
  	change_column :parts, :product_line, :string
  	remove_column :product_lines, :old_id
  end
end

class CreateProductLines < ActiveRecord::Migration
  def change
    create_table :product_lines do |t|
      t.string :description
      t.text :notes
      t.string :prefix

      t.timestamps
    end
  end
end

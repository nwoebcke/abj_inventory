class CreateGarages < ActiveRecord::Migration
  def change
    create_table :garages do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip

      t.timestamps
    end
  end
end

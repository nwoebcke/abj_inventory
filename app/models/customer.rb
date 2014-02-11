class Customer < ActiveRecord::Base
  attr_accessible :old_id, :address, :city, :email, :name, :phone, :state, :zip, :customer_product_lines, :product_lines
  has_many :customer_product_lines
  has_many :product_lines, :through => :customer_product_lines
end

class ProductLine < ActiveRecord::Base
  attr_accessible :old_id, :description, :notes, :prefix, :customer_product_lines, :customers
  has_many :customer_product_lines
  has_many :customers, :through => :customer_product_lines
  has_many :parts
end

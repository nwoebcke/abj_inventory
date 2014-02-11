class CustomerProductLine < ActiveRecord::Base
  attr_accessible :name
  belongs_to :customer
  belongs_to :product_line
end

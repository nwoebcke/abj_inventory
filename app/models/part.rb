class Part < ActiveRecord::Base
  attr_accessible :po_items, :description, :part_num, :price0, :price1, :price2, :price3, :price4, :price5, :product_line
  belongs_to :product_line
  has_many :po_items, :class_name => "PartPurchaseOrder"
  has_many :purchase_orders, :through => :po_items
end

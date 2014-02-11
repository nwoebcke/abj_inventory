class PurchaseOrder < ActiveRecord::Base
  attr_accessible :items, :delivery_date, :is_open, :order_date, :po_num, :customer
  has_many :items, :class_name => "PartPurchaseOrder"
  has_many :parts, :through => :items
  belongs_to :customer

  scope :is_open, where(:is_open => true)
end

class PartPurchaseOrder < ActiveRecord::Base
  attr_accessible :date_counted, :count_qty, :part, :purchase_order
  belongs_to :part
  belongs_to :purchase_order
end

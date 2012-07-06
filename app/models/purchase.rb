class Purchase < ActiveRecord::Base
  attr_accessible :annotation, :item_id, :item_value, :payment_type, :status, :transaction_date, :transaction_id
end

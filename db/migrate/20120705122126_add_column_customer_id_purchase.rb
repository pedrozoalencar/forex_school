class AddColumnCustomerIdPurchase < ActiveRecord::Migration
  def up
  	add_column :purchases, :customer_id, :integer 
  end

  def down
  	remove_column :purchases, :customer_id
  end
end

class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.string :transaction_id
      t.string :annotation
      t.date :transaction_date
      t.string :payment_type
      t.string :status
      t.integer :item_id
      t.decimal :item_value

      t.timestamps
    end
  end
end

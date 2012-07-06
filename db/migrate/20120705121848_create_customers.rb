class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.string :address
      t.string :address_number
      t.string :address_completion
      t.string :neighborhood
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :phone_number

      t.timestamps
    end
  end
end

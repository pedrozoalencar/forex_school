class Customer < ActiveRecord::Base
  attr_accessible :address, :address_completion, :address_number, :city, :email, :name, :neighborhood, :phone_number, :state, :zipcode
end

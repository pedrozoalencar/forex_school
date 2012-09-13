class AddColumnSkypeUsernameContactForm < ActiveRecord::Migration
  def up
  	add_column :contact_forms, :skype_username, :string
  end

  def down
  	remove_column :contact_forms, :skype_username
  end
end

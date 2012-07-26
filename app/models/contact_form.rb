class ContactForm < ActiveRecord::Base
  attr_accessible :email
  validates_presence_of :email
  validates :email, :email_format => {:message => I18n.t(:invalid_email_format, :scope => "activerecord.errors.messages")}

end

class UserMailer < ActionMailer::Base
  include SendGrid
  sendgrid_category :use_subject_lines
  sendgrid_enable   :ganalytics, :opentrack, :clicktrack
  
  default from: "contact@fxaddictsschool.com"

  def purchase_completed(purchase)
  	@purchase = purchase

  	sendgrid_category "Purchase Completed"
  	mail(:to=> purchase.customer.email, :subject => t('Parabéns Por sua aquisição!'))
  end
end

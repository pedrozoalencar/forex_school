# encoding: UTF-8

class UserMailer < ActionMailer::Base
  include SendGrid
  sendgrid_category :use_subject_lines
  sendgrid_enable   :ganalytics, :opentrack, :clicktrack
  
  default from: "Fx Addicts School contato@fxaddictsschool.com"

  def purchase_completed(purchase)
  	@purchase = purchase

  	sendgrid_category "Purchase Completed"
  	mail(:to=> purchase.customer.email, :subject => 'Sua compra foi efetuada com sucesso!')	
  end

  def signed_to_analysis_room(contact_form)
  	@contact_form = contact_form

  	sendgrid_category "Signed to Analysis Room"
  	mail(:to=> contact_form.email, :subject => "Sua inscrição foi efetuada com sucesso")	
  end


end

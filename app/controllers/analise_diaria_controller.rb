class AnaliseDiariaController < ApplicationController
	layout 'analise_diaria'

	def index
		@contact_form = ContactForm.new
	end
end

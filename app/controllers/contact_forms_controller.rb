class ContactFormsController < ApplicationController
  respond_to :json,:js,:html,:xml

  # GET /contact_forms
  # GET /contact_forms.json
  def index
    @contact_forms = ContactForm.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contact_forms }
    end
  end

  # GET /contact_forms/1
  # GET /contact_forms/1.json
  def show
    @contact_form = ContactForm.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @contact_form }
    end
  end

  # GET /contact_forms/new
  # GET /contact_forms/new.json
  def new
    @contact_form = ContactForm.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contact_form }
    end
  end

  # GET /contact_forms/1/edit
  def edit
    @contact_form = ContactForm.find(params[:id])
  end

  # POST /contact_forms
  # POST /contact_forms.json
  def create
    @contact_form = ContactForm.new(params[:contact_form])
    
    @contact_form.save

    UserMailer.signed_to_analysis_room(@contact_form).deliver
  
    respond_with @contact_form
    # respond_to do |format|
    #   if @contact_form.save
    #     format.html { redirect_to contact_forms_path, notice: 'Contact form was successfully created.' }
    #     format.json { render json: @contact_form, status: :created, location: @contact_form }
    #   else
    #     format.html { render action: "new" }
    #     format.json { render json: @contact_form.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PUT /contact_forms/1
  # PUT /contact_forms/1.json
  def update
    @contact_form = ContactForm.find(params[:id])

    respond_to do |format|
      if @contact_form.update_attributes(params[:contact_form])
        format.html { redirect_to @contact_form, notice: 'Contact form was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @contact_form.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contact_forms/1
  # DELETE /contact_forms/1.json
  def destroy
    @contact_form = ContactForm.find(params[:id])
    @contact_form.destroy

    respond_to do |format|
      format.html { redirect_to contact_forms_url }
      format.json { head :no_content }
    end
  end
end

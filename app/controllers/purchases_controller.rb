class PurchasesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  # GET /purchases
  # GET /purchases.json
  def index
    @purchases = Purchase.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @purchases }
    end
  end

  # GET /purchases/1
  # GET /purchases/1.json
  def show
    @purchase = Purchase.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @purchase }
    end
  end

  # GET /purchases/new
  # GET /purchases/new.json
  def new
    @purchase = Purchase.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @purchase }
    end
  end

  # GET /purchases/1/edit
  def edit
    @purchase = Purchase.find(params[:id])
  end

  # POST /purchases
  # POST /purchases.json
  def create
    @purchase = Purchase.new(params[:purchase])

    respond_to do |format|
      if @purchase.save
        format.html { redirect_to @purchase, notice: 'Purchase was successfully created.' }
        format.json { render json: @purchase, status: :created, location: @purchase }
      else
        format.html { render action: "new" }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /purchases/1
  # PUT /purchases/1.json
  def update
    @purchase = Purchase.find(params[:id])

    respond_to do |format|
      if @purchase.update_attributes(params[:purchase])
        format.html { redirect_to @purchase, notice: 'Purchase was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchases/1
  # DELETE /purchases/1.json
  def destroy
    @purchase = Purchase.find(params[:id])
    @purchase.destroy

    respond_to do |format|
      format.html { redirect_to purchases_url }
      format.json { head :no_content }
    end
  end
  
  # POST /purchase/completed
  def completed
    puts "######################## TO AQUI!"
    if request.post? then
      pagseguro_notification do |notification|
        
        customer = Customer.find_by_email(notification.buyer[:email])

        if (customer == nil) then
          customer = Customer.new
        end

        customer.name = notification.buyer[:name]
        customer.email = notification.buyer[:email]
        customer.address = notification.buyer[:address][:street]
        customer.address_number = notification.buyer[:address][:number]
        customer.address_completion = notification.buyer[:address][:complements]
        customer.neighborhood = notification.buyer[:address][:neighbourhood]
        customer.city = notification.buyer[:address][:city]
        customer.state = notification.buyer[:address][:state]
        customer.zipcode = notification.buyer[:address][:postal_code]

        customer.save!

        item = Item.find(notification.products[0][:id])

        purchase = Purchase.new
        purchase.transaction_id = notification.mapping_for(:order_id)
        purchase.annotation = notification.mapping_for(:notes)
        purchase.transaction_date = notification.processed_at
        purchase.payment_type = notification.payment_method
        purchase.status = notification.status
        purchase.item_value = notification.products[0][:price]
        purchase.customer = customer
        purchase.item = item
        purchase.save!



        # Aqui voce deve verificar se o pedido possui os mesmos produtos
        # que voce cadastrou. O produto soh deve ser liberado caso o status
        # do pedido seja "completed" ou "approved"

        puts "antes de entrar"
        puts "PURSCAHSE.STATUS \"#{purchase.status}\""
        puts "PUSRCHASE.ITEM_VALUSE #{purchase.item_value}"
        puts "ITEM.VALUE #{item.price}"
        puts purchase.status.to_s == "completed"
        if (purchase.status.to_s == "completed" or purchase.status.to_s == "approved") && purchase.item_value == item.price then
          puts "entrou"

          if purchase.status.to_s == "completed" then
            p1 = Purchase.find_all_by_transaction_id_and_status(purchase.transaction_id,"approved")[0];

            return unless p1 == nil
          end 

          UserMailer.purchase_completed(purchase).deliver
        end
      end
    end
    
    respond_to do |format|
          format.html { redirect_to root_url, notice: 'Purchase was successfully created.' }
    end

  end
end
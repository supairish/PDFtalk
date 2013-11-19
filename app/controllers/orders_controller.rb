class OrdersController < ApplicationController
  def index
    @orders = Order.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
      format.pdf do
        @title    = "Orders for #{ Time.zone.now.strftime("%m/%d/%Y") }"
        @filename = "#{ @title.gsub(/[\s\/]/, '-') }.pdf"

        render(:pdf          => @filename,
               :template     => 'orders/index.pdf',
               :layout       => 'layouts/print.html',
               :show_as_html => params[:debug].present?,
               :page_size    => 'Letter',
               :orientation  => 'Landscape',
               :margin       => {:top    => 5,
                                 :bottom => 5,
                                 :left   => 5,
                                 :right  => 5})

      end
    end
  end

  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
      format.pdf do
        render(:pdf          => "Order-#{@order.id}.pdf",
               :template     => 'orders/show.pdf',
               :layout       => 'layouts/print.html',
               :show_as_html => params[:debug].present?,
               :page_size    => 'Letter',
               :orientation  => 'Landscape',
               :margin       => {:top    => 5,
                                 :bottom => 5,
                                 :left   => 5,
                                 :right  => 5})
      end
    end
  end

  # GET /orders/new
  # GET /orders/new.json
  def new
    @order = Order.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(params[:order])

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render json: @order, status: :created, location: @order }
      else
        format.html { render action: "new" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end
end

class SnacksController < ApplicationController

  # GET /snacks/1

  before_filter :show, only:[:total_orders, :whos_order_what, :todays_order]

  def show
    @snack = Snack.where(created_at:
                         DateTime.now.midnight..DateTime.now.advance(days: 1).midnight).last
    @orders = []
    @grouped_orders = []
    @orders = @snack.orders     if @snack
    @grouped_orders = grouped_orders if !@orders.empty?
  end

  def total_orders
    total_orders_json = []
    grouped_orders.each do |k, v|
      quantity = v.map{|o| o.quantity.to_i}.inject(0, :+)
      special_instructions = v.select{|o| !o.special_instructions.blank?}.map{|vv| "#{vv.special_instructions} in 1 order"}.join(', ')
      total_orders_json << {food_name: k, quantity: quantity, special_instructions: special_instructions }
    end

    render json: total_orders_json
  end

  def whos_order_what
    whos_order_what = []
    @orders.each do |order|
      #quantity = v.map{|o| o.quantity.to_i}.inject(0, :+)
      #special_instructions = v.select{|o| !o.special_instructions.blank?}.map{|vv| "#{vv.special_instructions} in 1 order"}.join(', ')
      whos_order_what << {ordered_by: order.ordered_by.capitalize,
                            food_name: order.name,
                            quantity: order.quantity,
                            special_instructions: order.special_instructions }
    end

    render json: whos_order_what
  end

  def todays_order
    snack = []
    snack << {snacks: @snack.name.split(", "), provider: @snack.provider.titleize, price: @snack.price}
    render json: snack
  end

  # GET /snacks/new
  def new
    @snack = Snack.new
  end

  # GET /snacks/1/edit
  def edit
  end

  # POST /snacks
  def create
    @snack = Snack.new(snack_params)
    if @snack.save
      redirect_to :root
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /snacks/1
  def update
    if @snack.update(snack_params)
      redirect_to @snack, notice: 'Snack was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def place_order
    params[:order].permit!
    params[:order][:name] = params[:custom_snack_name] if !params[:custom_snack_name].blank?
    Order.create(params[:order]) if !params[:order][:name].blank?
    redirect_to :root
  end

  # DELETE /snacks/1
  def destroy
    @snack.destroy
    redirect_to snacks_url, notice: 'Snack was successfully destroyed.'
  end

  def destroy_order
    Order.find(params[:id]).destroy
    redirect_to :root
  end

  private
    def snack_params
      params[:snack].permit!
    end

    def grouped_orders
      @orders.group_by{|o| o.name}
    end

end

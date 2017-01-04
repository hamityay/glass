class Customer::OrdersController < Customer::CustomerApplicationController
  include ActionView::Helpers::NumberHelper
  before_action :authenticate_customer!, only: [:index, :new, :create]
  after_action :inc_total, only: [:create, :update]
  before_action :set_order, only: [:edit, :update, :destroy]
  before_action :dec_total, only: [:destroy]

  add_breadcrumb I18n.t('dock.dashboard'), :customer_orders_path

  def index
    @search = current_customer.orders.order(id: :desc).search(params[:q])
    @orders = @search.result(distinct: true).paginate(page: params[:page])
    respond_with(@orders)
  end

  def new
    @order = Order.new
  end

  def create
    @customer = current_customer
    @order = @customer.orders.new
    if @order.update(order_params)
      @order.quantity = ((@order.width * @order.height * @order.count ) / 1000000.0).round(2)
      @order.date = Date.today
      @order.state = 'Siparişiniz ulaştı'
      @order.amount = ( @order.quantity * @order.products.first.price * 1.18 ).round(2)
      if @order.customer.total == nil
        @order.customer.total = @order.amount.round
      end
      @order.save
      flash[:success] = 'Sipariş başarılı bir şekilde kaydedilmiştir'
      redirect_to new_customer_order_path
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    @order.customer.total = @order.customer.total - @order.amount
    @order.customer.save
    if @order.update(order_params)
      @order.quantity = ((@order.width * @order.height * @order.count ) / 1000000.0).round(2)
      @order.date = Date.today
      @order.amount = ( @order.quantity * @order.products.first.price * 1.18 ).round(2)
      @order.save
      flash[:success] = 'Sipariş başarılı bir şekilde güncellendi'
      if customer_signed_in?
        redirect_to customer_orders_path
      else
        redirect_to user_orders_path(@order.customer)
      end
    else
      render 'edit'
    end
  end

  def destroy
    customer = @order.customer
    @order.destroy
    flash[:success] = 'Sipariş başarılı bir şekilde silindi'
    if customer_signed_in?
      redirect_to customer_orders_path
    else
      redirect_to user_orders_path(customer)
    end
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:width, :height, :count, :state, :deadline, :info, :product_ids)
    end

    def inc_total
      @order.customer.total = @order.customer.total + @order.amount if @order.customer.orders.count != 1
      @order.customer.save
    end

    def dec_total
      @order.customer.total = @order.customer.total - @order.amount.to_i
      @order.customer.save
    end
end
class Customer::OrdersController < Customer::CustomerApplicationController
  before_action :set_order, only: [:edit, :update, :destroy, :toggle_is_active]
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
      @order.quantity = ( @order.width * @order.height * @order.count ) / 1000000.0
      @order.date = Date.today
      @order.state = 'Siparişiniz alındı'
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

  end

  def destroy
    @order.destroy
    redirect_to customer_orders_path
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:width, :height, :count, :deadline, :info)
    end
end
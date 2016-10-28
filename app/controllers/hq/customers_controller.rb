class Hq::CustomersController < Hq::ApplicationController

  before_action :set_customer, only: [:show, :edit, :update, :destroy, :toggle_is_active]
  add_breadcrumb I18n.t('activerecord.models.customers'), :hq_customers_path

  def index
    @search = Customer.order(id: :desc).search(params[:q])
    @customers = @search.result(distinct: true).paginate(page: params[:page])
    respond_with(@customers)
  end

  def show
    add_breadcrumb @customer.name, hq_customer_path(@customer)
    respond_with(@customer)
  end

  def new
    add_breadcrumb t('tooltips.new'), new_hq_customer_path
    @customer = Customer.new
    respond_with(@customer)
  end

  def edit
    add_breadcrumb @customer.name, hq_customer_path(@customerr)
    add_breadcrumb t('tooltips.edit'), edit_hq_customer_path
  end

  def create
    @customer = Customer.new(customer_params)
    @customer.save
    respond_with(:hq, @customer)
  end

  def update
    @customer.update(customer_params)
    respond_with(:hq, @customer)
  end

  def destroy
    @customer.destroy
    respond_with(:hq, @customer, location: request.referer)
  end

  def toggle_is_active
    if @customer.update( is_active: !@customer.is_active )
      @customer.is_active ?
        flash[:info] = t('flash.actions.toggle_is_active.active', resource_name: Customer.model_name.human) :
        flash[:info] = t('flash.actions.toggle_is_active.passive', resource_name: Customer.model_name.human)
    else
      flash[:danger] = t('flash.messages.error_occurred')
    end
    respond_with(:hq, @customer, location: request.referer)
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:email, :name, :surname, :address, :phone, :officer)
  end
end

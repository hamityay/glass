class User::DashboardController < User::UserApplicationController

  add_breadcrumb I18n.t('dock.dashboard'), :user_dashboard_index_path

  def index
  end

  def orders
    @customer = Customer.find(params[:id])
    @search = @customer.orders.order(id: :desc).search(params[:q])
    @orders = @search.result(distinct: true).paginate(page: params[:page])
    #respond_with(@orders)
  end

end
class Customer::DashboardController < Customer::CustomerApplicationController

  add_breadcrumb I18n.t('dock.dashboard'), :customer_dashboard_index_path

  def index
  end

end
class Customer::RegistrationsController < Devise::RegistrationsController
  # layout 'customer/application'
  before_action :authenticate_customer!, except: [:new, :create]
  before_action :redirect_customer, only: [:destroy]
  add_breadcrumb I18n.t('activerecord.models.customer'), :customer_root_path

  def new
    super
  end

  def edit
  end

  private

  def redirect_customer
    redirect_to customer_root_path
  end

  def after_update_path_for(resource)
    customer_root_path
  end

end

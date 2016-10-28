class Customer::ProfileController < Customer::CustomerApplicationController

  before_action :set_profile, only: [:show, :edit, :update]
  add_breadcrumb I18n.t('dock.profile'), :customer_profile_path

  def show
    add_breadcrumb @profile.full_name, customer_profile_path
    respond_with([:customer, @profile])
  end

  def edit
    add_breadcrumb t('tooltips.edit'), edit_customer_profile_path
  end

  def update
    @profile.update(profile_params)
    respond_with([:user, @profile], location: coostumer_profile_path)
  end

  private

  def set_profile
    @profile = current_customer
  end

  def profile_params
    params.require(:customer)
      .permit(
        :name,
        :surname,
        :time_zone,
        :phone,
        :address,
        :officer
    )
  end
end

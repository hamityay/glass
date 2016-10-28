class Customer::PasswordsController < Devise::PasswordsController
  # layout 'customer/login'

  private

  def after_resetting_password_path_for(resource)
    customer_root_path
  end

end

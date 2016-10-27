class Customer::ParameterSanitizer < Devise::ParameterSanitizer
  private
  def sign_up
    default_params.permit(:name, :surname, :email, :password, :password_confirmation, :address, :phone, :officer) # TODO add other params here
  end
end

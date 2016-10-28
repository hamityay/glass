require 'application_responder'

class Customer::CustomerApplicationController < ActionController::Base

  # layout 'user/application'
  layout 'application'
  #before_filter :set_audit_customer
  before_action :authenticate_customer!

  self.responder = ApplicationResponder
  respond_to :html, :json

  private

  def set_audit_customer
    # Set audit current customer
    Audited.current_customer_method = :current_customer
  end

end
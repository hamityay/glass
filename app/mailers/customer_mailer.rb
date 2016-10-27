class CustomerMailer < BaseMailer

  def login_info(customer_id, password)
    @customer   = Admin.find customer_id
    @password   = password
    @subject    = t('email.customer.login_info.title')
    mail(to: @customer.email, subject: @subject)
  end

end

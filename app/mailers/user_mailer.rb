class OwnerMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(owner)
    @owner = owner

    mail to: owner.email,
    	 subject: "Reset Password"
  end
end

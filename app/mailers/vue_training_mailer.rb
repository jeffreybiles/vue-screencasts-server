class VueTrainingMailer < ApplicationMailer
  def login_info(email, password)
    @email = email
    @password = password
    mail(to: @email, subject: 'Welcome to VueTraining!  Here\'s your login info.')
  end

  def already_exists(email)
    @email = email
    mail(to: @email, subject: 'Welcome to VueTraining!  Here\'s your login info.')
  end
end
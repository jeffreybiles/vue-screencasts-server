class VueTrainingMailerPreview < ActionMailer::Preview
  def login_info
    VueTrainingMailer.login_info('test@email.com', 'password')
  end

  def already_exists
    VueTrainingMailer.already_exists('test@email.com')
  end
end
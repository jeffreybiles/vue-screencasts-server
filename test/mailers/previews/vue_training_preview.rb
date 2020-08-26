class VueTrainingMailerPreview < ActionMailer::Preview
  def login_info
    VueTrainingMailer.login_info('test@email.com', 'password')
  end
end
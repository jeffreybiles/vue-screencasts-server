require 'sendgrid-ruby'
include SendGrid

class SendgridMailer
  def self.sendgrid
    SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
  end

  def self.send_mail(mail)
    self.sendgrid.client.mail._('send').post(request_body: mail.to_json)
  end
  
  def self.from(email = 'jeffrey@vuescreencasts.com')
    Email.new(email: email)
  end

  def self.send_release_email(video, user)
    mail = SendGrid::Mail.new
    mail.template_id = "d-e052a496b0a34e129b890858e340383f"
    mail.subject = "New Video: #{video.name}"
    mail.from = self.from
    
    personalization = Personalization.new
    personalization.add_to(email: user.email, name: user.name)
    personalization.add_dynamic_template_data({
      "video" => [
        {"name" => video.name},
        {"description" => video.description}, #maybe do a markdown to html conversion here
        {"url" => "https://www.vuescreencasts.com/watch/#{video.id}"},
        {"thumbnail" => video.thumbnail}
      ]
    })
    mail.add_personalization(personalization)

    self.send_mail(mail)
  end
end
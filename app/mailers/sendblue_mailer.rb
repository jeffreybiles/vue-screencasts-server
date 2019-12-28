require 'sib-api-v3-sdk'

class SendBlueMailer
  def smtp_api
    cached_smtp_api ||= SibApiV3Sdk::SMTPApi.new
  end

  def send_new_video_email(video, user)
    {
      from: SibApiV3Sdk::SendSmtpEmailSender(email: 'video_notifications@vuescreencasts.com', name: "VueScreencasts"),
      reply_to: SibApiV3Sdk::SendSmtpEmailReplyTo(email: 'jeffrey@vuescreencasts.com'),
      template_id: '',
      to: {email: user.email},
      params: {
        video_name: video.name,
        video_description: video.description,
        video_url: "https://www.vuescreencasts.com/watch/#{video.id}",
        video_thumbnail: video.thumbnail,
        unsubscribe_link: unsubscribe_link(user)
      }
    }
  end

  def unsubscribe_link(user)
    "https://www.vuescreencasts.com/edit_email_subscription/#{user.id}/#{user.email_subscription_token}"
  end

  def send(props)
    send_smtp_email = SibApiV3Sdk::SendSmtpEmail.new(props)
    begin
      result = smtp_api.send_transac_email(send_smtp_email)
      p result
    rescue SibApiV3Sdk::ApiError => e
      puts "Exception when calling EmailCampaignsApi->create_email_campaign: #{e}"
    end
  end
end

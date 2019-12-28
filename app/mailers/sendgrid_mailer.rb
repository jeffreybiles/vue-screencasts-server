require 'sendgrid-ruby'
include SendGrid

class SendgridMailer
  def self.sendgrid
    SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
  end

  def self.send_email(template_id, substitutions, to_email)
    data = {
      "personalizations": [
        {
          "to": [
            {
              "email": to_email
            }
          ],
          "dynamic_template_data": substitutions
        }
      ],
      "from": {
        "email": 'jeffrey@vuescreencasts.com'
      },
      "template_id": template_id
    }

    self.sendgrid.client.mail._("send").post(request_body: data)
  end

  def self.send_release_email(video, user)
    template_id = "d-e052a496b0a34e129b890858e340383f"
    #TODO: need to make this safe;
    # do a markdown to html conversion for the video.description
    # and also strip out any tags (such as <script>) that will mess stuff up
    #TODO 2: Take the thumbnail from the course if one doesn't exist on the video
    substitutions = {
      video_name: video.name,
      video_description: video.description,
      video_url: "https://www.vuescreencasts.com/watch/#{video.id}",
      video_thumbnail: video.thumbnail
    }
    to_email = user.email

    self.send_email(template_id, substitutions, to_email)
  end
end
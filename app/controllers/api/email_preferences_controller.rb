require 'sib-api-v3-sdk'
require 'uri'
require 'net/http'
require 'openssl'

class Api::EmailPreferencesController < ApplicationController
  def newsletter_subscribe
    user = current_user
    user.email_weekly = true
    user.save

    signup_user_for_newsletter(user)

    head 200
  end

  def change_subscription
    id = params['id']
    new_status = params['isSubscribed']

    begin
      contact = api_instance.get_contact_info(current_user.email)

      if new_status
        update_subscription(current_user.email, id, 'add')
      else
        update_subscription(current_user.email, id, 'remove')
      end
    rescue
      create_contact(current_user, [id])
    end


  end

  def status
    begin
      #Retrieves contact informations
      result = api_instance.get_contact_info(current_user.email)
      render json: {
        contact: result,
        newsletters: newsletters
      }
    rescue SibApiV3Sdk::ApiError => e
      puts "Exception when calling ContactsApi->get_contact_info: #{e}"
      render json: {
        newsletters: newsletters
      }
    end
  end

  private

  def create_contact(user, newsletters)
    create_contact = SibApiV3Sdk::CreateContact.new(email: user.email, listIds: newsletters)

    begin
      #Create a contact
      result = api_instance.create_contact(create_contact)
      p result
    rescue SibApiV3Sdk::ApiError => e
      puts "Exception when calling ContactsApi->create_contact: #{e}"
      head 500
    end
  end

  def update_subscription(email, list_id, add_or_remove)
    begin
      url = URI("https://api.sendinblue.com/v3/contacts/lists/#{list_id}/contacts/#{add_or_remove}")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Post.new(url)
      request["accept"] = 'application/json'
      request["content-type"] = 'application/json'
      request["api-key"] = ENV['SENDBLUE_API_KEY']
      request.body = "{\"emails\":[\"#{email}\"]}"

      response = http.request(request)
      p response
    rescue SibApiV3Sdk::ApiError => e
      puts "Exception when calling ContactsApi->add_contact_to_list: #{e}"
      head 500
    end
  end

  def unsubscribe_user(user, newsletter)

  end

  def api_instance
    SibApiV3Sdk::ContactsApi.new
  end

  def newsletters
    [{
      id: 3,
      name: 'Weekly Newsletter',
      description: "A weekly newsletter with the biggest updates of the week, including that week's new course."
    }, {
      id: 6,
      name: 'MiniCasts Updates',
      description: "Get a notification email whenever I release a new video or course.  Expect several per week."
    }, {
      id: 7,
      name: "Comment Notifications",
      description: "Get a notification email whenever someone responds to one of your comments."
    }]
  end
end
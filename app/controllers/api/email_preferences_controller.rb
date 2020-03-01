require 'sib-api-v3-sdk'
require 'uri'
require 'net/http'
require 'openssl'

class Api::EmailPreferencesController < ApplicationController
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

  def passwordless_subscription
    begin
      Email.create_sendinblue_contact(params[:email], [3, 6])

      head 200
    rescue Error => e 
      puts "There was an error when adding user to a newsletter: #{e}"
      render json: {
        error: e
      }
    end
  end

  def status
    begin
      #Retrieves contact informations
      result = api_instance.get_contact_info(current_user.email)
      render json: {
        contact: result,
      }
    rescue SibApiV3Sdk::ApiError => e
      puts "Exception when calling ContactsApi->get_contact_info: #{e}"
      render json: { }
    end
  end

  private

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

  def api_instance
    SibApiV3Sdk::ContactsApi.new
  end
end
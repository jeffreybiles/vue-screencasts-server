require 'sib-api-v3-sdk'
require 'uri'
require 'net/http'
require 'openssl'

class Api::EmailPreferencesController < ApplicationController
  def change_subscription
    id = params['id']
    is_subscribed = params['isSubscribed']

    # begin
    result = Email.new.update_subscription(current_user, id, is_subscribed)
    head result.status
    # rescue
    #   create_contact(current_user, [id])
    # end
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
      result = Email.new.contact(current_user)
      render json: {
        contactLists: result['contactLists']
      }
    rescue SibApiV3Sdk::ApiError => e
      puts "Exception when calling ContactsApi->get_contact_info: #{e}"
      render json: { }
    end
  end

  private

  def api_instance
    SibApiV3Sdk::ContactsApi.new
  end
end
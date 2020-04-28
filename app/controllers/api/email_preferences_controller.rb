require 'uri'
require 'net/http'
require 'openssl'

class Api::EmailPreferencesController < ApplicationController
  def change_subscription
    id = params['id']
    is_subscribed = params['isSubscribed']

    result = Email.new.update_subscription(current_user, id, is_subscribed)
    # TODO: put in error handling
    head 200
  end

  def status
    result = Email.new.contact(current_user)
    render json: {
      contactLists: result['contactLists']
    }
  end
end
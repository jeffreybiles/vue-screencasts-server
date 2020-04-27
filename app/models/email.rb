class Email
  def self.create_sendinblue_contact(email, newsletters)
    return if Rails.env == 'development'

    api_instance = SibApiV3Sdk::ContactsApi.new
    create_contact = SibApiV3Sdk::CreateContact.new(email: email, listIds: newsletters)

    #Create a contact
    result = api_instance.create_contact(create_contact)
    p result    
  end

  def contact(user)
    get("contacts/2")
  end

  def update_subscription(user, list_id, is_subscribed)
    post('contactLists', {
      contactList: {
        list: list_id,
        contact: 2,
        status: is_subscribed ? 1 : 2
      }
    })
  end

  def get(url, props = {})
    JSON.parse(Faraday.get("#{base_url}/#{url}", props, {"Api-Token" => api_key, "Content-Type" => "application/json"}).body)
  end

  def post(url, props = {})
    Faraday.post("#{base_url}/#{url}", props.to_json, {"Api-Token" => api_key})
  end

  def base_url
    ENV['ACTIVE_CAMPAIGN_BASE_URL']
  end

  def api_key
    ENV['ACTIVE_CAMPAIGN_API_KEY']
  end
end
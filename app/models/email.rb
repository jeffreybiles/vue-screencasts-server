class Email
  def self.create_sendinblue_contact(email, newsletters)
    return if Rails.env == 'development'

    api_instance = SibApiV3Sdk::ContactsApi.new
    create_contact = SibApiV3Sdk::CreateContact.new(email: email, listIds: newsletters)

    #Create a contact
    result = api_instance.create_contact(create_contact)
    p result    
  end

  def contact(email)
    get("contacts/2")['contact']
  end

  def get(url, props = {})
    JSON.parse(Faraday.get("#{base_url}/#{url}", props, {"Api-Token" => api_key}).body)
  end

  def base_url
    ENV['ACTIVE_CAMPAIGN_BASE_URL']
  end

  def api_key
    ENV['ACTIVE_CAMPAIGN_API_KEY']
  end
end
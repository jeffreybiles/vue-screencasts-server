class Email
  def contact(user)
    get("contacts/#{user.active_campaign_id}")
  end

  def update_subscription(user, list_id, is_subscribed)
    post('contactLists', {
      contactList: {
        list: list_id,
        contact: user.active_campaign_id,
        status: is_subscribed ? 1 : 2
      }
    })
  end

  def create_contact(user)
    post('contact/sync', {
      contact: {
        email: user.email,
        firstName: user.name
      }
    })
  end

  def update_contact(user)
    put("contacts/#{user.active_campaign_id}", {
      contact: {
        email: user.email,
        firstName: user.name
      }
    })
  end

  def get(url, props = {})
    parse Faraday.get("#{base_url}/#{url}", props, {"Api-Token" => api_key, "Content-Type" => "application/json"})
  end

  def post(url, props = {})
    parse Faraday.post("#{base_url}/#{url}", props.to_json, {"Api-Token" => api_key})
  end

  def put(url, props = {})
    parse Faraday.put("#{base_url}/#{url}", props.to_json, {"Api-Token" => api_key})
  end

  def parse(json)
    JSON.parse(json.body)
  end

  def base_url
    ENV['ACTIVE_CAMPAIGN_BASE_URL']
  end

  def api_key
    ENV['ACTIVE_CAMPAIGN_API_KEY']
  end
end
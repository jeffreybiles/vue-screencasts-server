task :connect_email_to_active_campaign => :environment do 
  contacts = Email.new.get("contacts")["contacts"]

  contacts.each do |contact|
    user = User.find_by(email: contact['email'])

    if user then
      user.active_campaign_id = contact['id']
      user.save!
    end
  end
end
task :connect_email_to_active_campaign => :environment do 
  total_results = Email.new.get("contacts?limit=2")['meta']['total'].to_i
  offset = 0
  limit = 20
  puts total_results
  while offset < total_results do
    contacts = Email.new.get("contacts?limit=#{limit}&offset=#{offset}")['contacts']
    puts "doing the thing"
    contacts.each do |contact|
      user = User.find_by(email: contact['email'])
  
      if user then
        user.active_campaign_id = contact['id']
        user.save!
      end
    end

    offset += limit
  end
  
end
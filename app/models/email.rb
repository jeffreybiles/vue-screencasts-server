class Email
  def self.create_sendinblue_contact(email, newsletters)
    api_instance = SibApiV3Sdk::ContactsApi.new
    create_contact = SibApiV3Sdk::CreateContact.new(email: email, listIds: newsletters)

    #Create a contact
    result = api_instance.create_contact(create_contact)
    p result    
  end
end
class Notification < ApplicationRecord
  belongs_to :comment
  belongs_to :user

  def comment_notification_list_id
    7
  end
  
  # TODO: Make this work
  def send_email
    # api_instance = SibApiV3Sdk::ContactsApi.new

    # result = api_instance.get_contact_info(user.email)
    # can_receive = result.list_ids.include?(comment_notification_list_id)
    # if can_receive

    # end
  end
end
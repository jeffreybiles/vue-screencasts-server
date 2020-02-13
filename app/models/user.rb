require 'digest/sha1'
Stripe.api_key = ENV['STRIPE_SECRET']

class User < ApplicationRecord
  has_many :comments
  has_many :notifications
  has_many :video_plays
  has_many :played_videos, through: :video_plays, class_name: 'video'
  before_save :downcase_fields

  def set_password(password)
    self.salt = Digest::SHA1.hexdigest("#{self.email}#{Time.now}")
    self.encrypted_password = Digest::SHA1.hexdigest("#{password}#{self.salt}")
    self.save
  end

  def set_token
    self.token = generate_token
    self.save
  end

  def set_email_token
    self.email_subscription_token = generate_token(Time.now + 20000)
    self.save
  end

  def generate_token(extra_salt = Time.now)
    Digest::SHA1.hexdigest("#{self.salt}#{extra_salt}")
  end

  def check_password(password)
    self.encrypted_password == Digest::SHA1.hexdigest("#{password}#{self.salt}")
  end

  def pro
    return calculate_pro
  end

  def calculate_pro
    return false if !self.subscription_id

    subscription_still_good = self.subscription_end_date && DateTime.now < self.subscription_end_date
    return true if subscription_still_good

    return false if self.subscription_cancelled

    update_pro_status
    return calculate_pro
  end

  def update_pro_status
    subscription = Stripe::Subscription.retrieve(self.subscription_id)
    self.subscription_end_date = Time.at(subscription.current_period_end)
    self.subscription_cancelled = !!subscription.canceled_at
    self.save
  end

  def __testing__clear_subscription
    self.subscription_cancelled = nil
    self.subscription_end_date = nil
    self.subscription_id = nil
    self.save
  end

  def downcase_fields
    self.email.downcase!
  end

  def create_sendinblue_contact(newsletters)
    api_instance = SibApiV3Sdk::ContactsApi.new
    create_contact = SibApiV3Sdk::CreateContact.new(email: self.email, listIds: newsletters)

    begin
      #Create a contact
      result = api_instance.create_contact(create_contact)
      p result
    rescue SibApiV3Sdk::ApiError => e
      puts "Exception when calling ContactsApi->create_contact: #{e}"
      head 500
    end
  end
end

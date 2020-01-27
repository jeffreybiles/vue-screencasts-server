require 'digest/sha1'
Stripe.api_key = ENV['STRIPE_SECRET']

class User < ApplicationRecord
  has_many :video_plays
  has_many :played_videos, through: :video_plays, class_name: 'video'

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

end

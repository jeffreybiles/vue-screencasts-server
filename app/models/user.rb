require 'digest/sha1'

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
    # This is a placeholder so it'll work nicely after signing up
    # TODO: make this calculate based on today's date and when the pro plan expires
    return !!self.subscription_id
  end
end

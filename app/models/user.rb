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
    self.token = Digest::SHA1.hexdigest("#{self.salt}#{Time.now}")
    self.save
  end

  def check_password(password)
    self.encrypted_password == Digest::SHA1.hexdigest("#{password}#{self.salt}")
  end
end

require 'digest/sha1'

class User < ApplicationRecord
  def set_password(password)
    self.salt = Digest::SHA1.hexdigest("#{self.email}#{Time.now}")
    self.encrypted_password = Digest::SHA1.hexdigest("#{password}#{self.salt}")
    self.save
  end

  def check_password(password)
    self.encrypted_password == Digest::SHA1.hexdigest("#{password}#{self.salt}")
  end
end

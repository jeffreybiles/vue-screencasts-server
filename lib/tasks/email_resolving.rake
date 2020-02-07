task :email_resolving => :environment do 
  User.all.each do |user|
    user.email.downcase!
    user.save!
  end
end
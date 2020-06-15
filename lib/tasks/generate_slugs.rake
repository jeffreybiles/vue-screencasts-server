task :generate_slugs => :environment do 
  Video.all.each do |video|
    video.slug = video.name.parameterize if video.slug.blank?
    video.save!
  end
end
namespace :heroku_db do
  desc "Take downloaded db dump and put it into dev dabatase"
  task :restore_to_dev do
    sh "pg_restore --verbose --clean --no-acl --no-owner -h localhost -U jeffreybiles -d vuescreencasts_dev latest.dump"
  end

  task :from_heroku_to_dev do
    sh "heroku pg:backups:capture"
    sh "curl -o latest.dump `heroku pg:backups:url`"
    sh "pg_restore --verbose --clean --no-acl --no-owner -h localhost -U jeffreybiles -d vuescreencasts_dev latest.dump"
  end
end


task :remove_numbers_from_videos => :environment do 
  Video.all.each do |video|
    video.name = video.name.gsub(/[\/\d\.]+ /, '')
    video.save
  end
end
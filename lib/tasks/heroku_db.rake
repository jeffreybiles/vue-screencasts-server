namespace :heroku_db do
  desc "Take downloaded db dump and put it into dev dabatase"
  task :restore_to_dev do
    sh "pg_restore --verbose --clean --no-acl --no-owner -h localhost -U jeffreybiles -d vuescreencasts_dev latest.dump"
  end

  task :from_heroku_to_dev do
    sh "heroku pg:backups:capture"
    sh "curl -o latest.dump `heroku pgbackups:url`"
    sh "pg_restore --verbose --clean --no-acl --no-owner -h localhost -U jeffreybiles -d vuescreencasts_dev latest.dump"
  end
end

namespace :heroku_db do
  desc "Take downloaded db dump and put it into dev dabatase"
  task :restore_to_dev do
    sh "pg_restore --verbose --clean --no-acl --no-owner -h localhost -U jeffreybiles -d vuescreencasts_dev latest.dump"
  end
end

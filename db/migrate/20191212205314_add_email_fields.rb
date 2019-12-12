class AddEmailFields < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :email_weekly, :boolean
    add_column :users, :email_daily, :boolean
    add_column :users, :email_subscription_token, :string

    User.all.each do |user|
      user.set_email_token
    end
  end
end

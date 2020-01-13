class AddSubscriptionProperties < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :subscription_end_date, :datetime
    add_column :users, :subscription_cancelled, :boolean
  end
end

class AddFreeSubscription < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :free_subscription, :boolean
  end
end

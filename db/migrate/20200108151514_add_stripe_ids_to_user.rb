class AddStripeIdsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :stripe_id, :string
    add_column :users, :subscription_id, :string
  end
end

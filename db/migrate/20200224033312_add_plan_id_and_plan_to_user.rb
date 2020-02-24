class AddPlanIdAndPlanToUser < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'hstore'

    add_column :users, :plan_id, :string
    add_column :users, :plan_hash, :hstore, default: {}
  end
end

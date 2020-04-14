class PlanSeats < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :plan_seats, :integer
  end
end

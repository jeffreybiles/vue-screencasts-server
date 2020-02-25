class AddNextStepsData < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :next_steps_taken, :hstore, default: {}
  end
end

class AddFieldsToVideo < ActiveRecord::Migration[6.0]
  def change
    change_table :videos do |t|
      t.column :duration, :integer
      t.column :release_time, :datetime
      t.column :code_summary, :text
    end
  end
end

class AddPublishedBoolToModule < ActiveRecord::Migration[6.0]
  def change
    add_column :training_modules, :state, :string, default: 'published'
  end
end

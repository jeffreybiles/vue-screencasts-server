class SwitchFromIdToUid < ActiveRecord::Migration[6.0]
  def change
    remove_column :training_items, :vimeo_id, :string
    add_column :training_items, :vimeo_uid, :string
  end
end

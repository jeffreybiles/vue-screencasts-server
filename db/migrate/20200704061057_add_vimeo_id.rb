class AddVimeoId < ActiveRecord::Migration[6.0]
  def change
    add_column :training_items, :vimeo_id, :string
  end
end

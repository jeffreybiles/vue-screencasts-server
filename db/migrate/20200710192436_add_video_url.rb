class AddVideoUrl < ActiveRecord::Migration[6.0]
  def change
    add_column :training_items, :video_url, :string
  end
end

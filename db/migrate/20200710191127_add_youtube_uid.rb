class AddYoutubeUid < ActiveRecord::Migration[6.0]
  def change
    add_column :training_items, :youtube_uid, :string
  end
end

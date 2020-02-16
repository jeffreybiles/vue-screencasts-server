class AddVideoIdToNotification < ActiveRecord::Migration[6.0]
  def change
    add_column :notifications, :video_id, :integer
  end
end

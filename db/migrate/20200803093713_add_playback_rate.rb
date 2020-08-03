class AddPlaybackRate < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :playback_rate, :decimal, default: 1.0
  end
end

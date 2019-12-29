class AddProOptionToVideos < ActiveRecord::Migration[6.0]
  def change
    add_column :videos, :pro, :boolean
  end
end

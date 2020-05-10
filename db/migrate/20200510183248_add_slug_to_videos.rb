class AddSlugToVideos < ActiveRecord::Migration[6.0]
  def change
    add_column :videos, :slug, :string
  end
end

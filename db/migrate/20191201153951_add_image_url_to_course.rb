class AddImageUrlToCourse < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :image_url, :string
  end
end

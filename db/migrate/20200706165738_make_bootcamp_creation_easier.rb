class MakeBootcampCreationEasier < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :bootcamp, :boolean
  end
end

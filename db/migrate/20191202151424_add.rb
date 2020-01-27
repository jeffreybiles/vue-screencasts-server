class Add < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :description, :text
  end
end

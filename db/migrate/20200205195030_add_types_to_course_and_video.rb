class AddTypesToCourseAndVideo < ActiveRecord::Migration[6.0]
  def change
    add_column :videos, :lesson_type, :string
  end
end

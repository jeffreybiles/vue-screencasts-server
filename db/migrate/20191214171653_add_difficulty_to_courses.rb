class AddDifficultyToCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :difficulty, :string
  end
end

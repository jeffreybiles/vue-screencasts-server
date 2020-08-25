class AddTrainingCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :training_courses do |t|
      t.string :name
      t.string :external_id

      t.timestamps
    end
  end
end

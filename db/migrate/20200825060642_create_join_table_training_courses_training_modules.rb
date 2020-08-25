class CreateJoinTableTrainingCoursesTrainingModules < ActiveRecord::Migration[6.0]
  def change
    create_join_table :training_courses, :training_modules do |t|
      # t.index [:training_course_id, :training_module_id]
      # t.index [:training_module_id, :training_course_id]
    end
  end
end

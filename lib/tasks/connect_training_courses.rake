task :create_training_courses => :environment do 
  ultimate = TrainingCourse.create(name: 'Vue Training Ultimate Package', external_id: 1)
  starter = TrainingCourse.create(name: 'Vue Training Starter Package', external_id: 3)
  expansion = TrainingCourse.create(name: 'Vue Training Expansion Package', external_id: 4)

  modules = TrainingModule.where(state: 'published').sort_by { |m| m.week_number } 
  modules.each do |m|
    ultimate.training_modules << m
    if m.week_number <= 4 then
      starter.training_modules << m
    else
      expansion.training_modules << m
    end
  end
end
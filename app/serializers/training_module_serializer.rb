class TrainingModuleSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :week_number, :intro, :state
  has_many :training_sections
  has_many :training_courses
end

class TrainingModuleSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :week_number
  has_many :training_sections
end

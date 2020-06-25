class TrainingModuleSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :week_number, :intro
  has_many :training_sections
end

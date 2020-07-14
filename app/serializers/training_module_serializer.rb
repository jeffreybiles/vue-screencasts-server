class TrainingModuleSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :week_number, :intro, :state
  has_many :training_sections
end

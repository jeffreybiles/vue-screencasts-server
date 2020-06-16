class TrainingSectionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :position, :training_module_id
  has_many :training_items
end

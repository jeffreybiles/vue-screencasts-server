class TrainingSectionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :position
  has_many :training_items
end

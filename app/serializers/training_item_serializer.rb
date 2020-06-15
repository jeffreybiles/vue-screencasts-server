class TrainingItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :position, :text
end

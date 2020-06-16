class TrainingItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :position, :text, :training_section_id
end

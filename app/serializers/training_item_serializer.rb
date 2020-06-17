class TrainingItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :position, :text, :exercise_type, :training_section_id
end

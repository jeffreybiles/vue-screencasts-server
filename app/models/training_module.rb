class TrainingModule < ApplicationRecord
  has_and_belongs_to_many :training_courses
  has_many :training_sections
end
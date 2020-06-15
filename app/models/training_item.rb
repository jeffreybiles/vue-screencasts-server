class TrainingItem < ApplicationRecord
  belongs_to :training_section
  has_many :training_completions
end
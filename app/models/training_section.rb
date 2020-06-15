class TrainingSection < ApplicationRecord
  has_many :training_items
  belongs_to :training_module
end
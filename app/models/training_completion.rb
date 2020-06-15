class TrainingCompletion < ApplicationRecord
  belongs_to :training_item
  belongs_to :user
end
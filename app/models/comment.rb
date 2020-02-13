class Comment < ApplicationRecord
  belongs_to :video
  belongs_to :user
  belongs_to :parent, optional: true, class_name: "Comment"
  has_many :comments, class_name: "Comment", foreign_key: "parent_id"
end
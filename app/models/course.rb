class Course < ApplicationRecord
  has_many :videos
  belongs_to :parent, optional: true, class_name: "Course"
  has_many :chapters, class_name: "Course", foreign_key: "parent_id"
end

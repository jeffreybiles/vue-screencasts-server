class Course < ApplicationRecord
  has_many :videos
  belongs_to :parent, optional: true, class_name: "Course"
  has_many :chapters, class_name: "Course", foreign_key: "parent_id"

  def max_order
    orders = self.chapters.map(&:order) + self.videos.map(&:order)
    orders.select{|x| x}.max
  end

  def is_active
    self.videos.map(&:lesson_type).include?('exercise')
  end
end

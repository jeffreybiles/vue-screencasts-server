class Course < ApplicationRecord
  has_many :videos
  belongs_to :parent, optional: true, class_name: "Course"
  has_many :chapters, class_name: "Course", foreign_key: "parent_id"

  def max_order
    orders = self.chapters.map(&:order) + self.videos.map(&:order)
    orders.select{|x| x}.max
  end

  def category
    self.videos.map(&:lesson_type).include?('Exercise') ? 'Interactive' : 'Watch Me Code'
  end

  # go through the description and title of every course and video to replace an old word with a new word.
  # First use was VueX -> Vuex
  def self.update_data(old_word, new_word)
    Course.all.each do |course|
      course.name = course.name.gsub(old_word, new_word)
      course.description = course.description.gsub(old_word, new_word)
      course.save
    end

    Video.all.each do |video|
      video.name = video.name.gsub(old_word, new_word)
      video.description = video.description.gsub(old_word, new_word)
      video.save
    end
  end
end

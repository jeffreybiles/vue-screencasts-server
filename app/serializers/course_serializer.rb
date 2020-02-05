class CourseSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :series_type, :image_url, :description, :order, :difficulty, :category
  has_many :videos
  belongs_to :parent, serializer: :course
  has_many :chapters
end

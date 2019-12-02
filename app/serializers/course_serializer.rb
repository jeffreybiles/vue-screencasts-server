class CourseSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :series_type, :image_url, :description, :order
  has_many :videos
  belongs_to :parent
  has_many :chapters
end

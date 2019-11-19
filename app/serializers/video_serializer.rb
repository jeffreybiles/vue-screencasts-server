class VideoSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :description, :videoUrl, :thumbnail, :created_at, :updated_at, :duration, :published_at, :code_summary
  has_many :tags
end

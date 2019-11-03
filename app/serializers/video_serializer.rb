class VideoSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :description, :videoUrl, :thumbnail, :duration, :release_time, :code_summary
  has_many :tags
end

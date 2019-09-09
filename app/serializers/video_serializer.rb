class VideoSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :description, :videoUrl, :thumbnail
end

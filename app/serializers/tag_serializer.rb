class TagSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name
  has_many :videos
end

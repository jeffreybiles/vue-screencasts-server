class VideoSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :description, :thumbnail, :pro, :in_free_period, :lesson_type,
             :created_at, :updated_at, :duration, :published_at, :order,
             :code, :code_summary, :code_summary_state, :videoUrl
  belongs_to :course

end

class VideoSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :description, :thumbnail, :pro, :in_free_period, :lesson_type,
             :created_at, :updated_at, :duration, :published_at, :code_summary, :order
  belongs_to :course
  
  attribute :comment_ids do |object|
    object.comments.map(&:id)
  end

  attribute :videoUrl, if: Proc.new { |record, params| 
    isFree = !record.pro
    userPro = params && params[:user_pro]
    freePeriod = record.in_free_period
    isFree || userPro || freePeriod
  } do |object|
    object.videoUrl
  end
end

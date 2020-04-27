class VideoSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :description, :thumbnail, :pro, :in_free_period, :lesson_type,
             :created_at, :updated_at, :duration, :published_at, :order,
             :code, :code_summary, :code_summary_state
  belongs_to :course

  attribute :videoUrl, if: Proc.new { |record, params| 
    isFree = !record.pro
    userPro = params && params[:user_pro]
    user_admin = params && params[:user_admin]
    freePeriod = record.in_free_period
    (isFree || userPro || freePeriod) && (record.released || user_admin)
  } do |object|
    object.videoUrl
  end
end

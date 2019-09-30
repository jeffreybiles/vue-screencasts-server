class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :email, :admin

  attribute :played_video_ids do |object|
    object.video_plays.map(&:video_id).uniq
  end

  attribute :token, if: Proc.new { |record, params|
    params && params[:token]
  }
end

class CommentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :content, :created_at, :video_id, :user_id, :parent_id, :comment_ids, :deleted

  attribute :username do |object|
    object.user.name
  end
end
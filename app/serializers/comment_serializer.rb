class CommentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :content, :created_at, :video_id, :user_id
end
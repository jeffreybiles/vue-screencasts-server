class NotificationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :content, :created_at, :video_id, :comment_id
end
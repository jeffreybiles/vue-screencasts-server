class NotificationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :content, :created_at
  has_one :comment, include: true
end
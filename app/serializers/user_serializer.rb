class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name, :email, :admin, :created_at, :pro, :subscription_cancelled, :subscription_end_date, :plan_id, :next_steps_taken, :plan_seats

  attribute :played_video_ids do |object|
    object.video_plays.map(&:video_id).uniq
  end

  attribute :completed_training_item_ids do |object|
    object.training_completions.map(&:training_item_id).uniq
  end

  attribute :completed_training_item_ids do |object|
    object.training_completions.map(&:training_item_id).uniq
  end

  attribute :has_stripe do |object|
    !!object.stripe_id && !!object.subscription_id
  end

  attribute :token, if: Proc.new { |record, params|
    params && params[:token]
  }

  attribute :s3_keys, if: Proc.new { |record, params|
    params && params[:admin]
  } do |object|
    {
      id: ENV['S3_ACCESS_KEY_ID'],
      secret: ENV['S3_ACCESS_KEY_SECRET'],
    }
  end
end

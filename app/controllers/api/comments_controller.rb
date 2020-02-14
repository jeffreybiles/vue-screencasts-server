class Api::CommentsController < ApplicationController
  def create
    comment = Comment.create(comment_params)
    comment.user = current_user
    comment.save

    message = "#{current_user.name} has responded to your post."

    admin_user = User.find(3)
    admin_notification = Notification.create(comment: comment, user: admin_user, content: message)
    # admin_notification.send_email

    if params[:parent_id]
      parent_comment = Comment.find(params[:parent_id])
      notification = Notification.create(comment: comment, user: parent_comment.user, content: message)
      # notification.send_email
    end

    render json: comment_json(comment)
  end

  def update
    comment = Comment.find(params[:id])
    if current_user.id == comment.user_id
      comment.content = params[:content] if params[:content]
      comment.deleted = params[:deleted] if params[:deleted] != nil
      comment.save
      render json: comment_json(comment)
    else
      head 400
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :video_id, :parent_id)
  end

  def comment_json(comments)
    CommentSerializer.new(comments).serializable_hash
  end
end
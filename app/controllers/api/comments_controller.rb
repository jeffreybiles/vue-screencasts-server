class Api::CommentsController < ApplicationController
  def create
    comment = Comment.create(comment_params)
    comment.user = current_user
    comment.save
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
    params.require(:comment).permit(:content, :video_id)
  end

  def comment_json(comments)
    CommentSerializer.new(comments).serializable_hash
  end
end
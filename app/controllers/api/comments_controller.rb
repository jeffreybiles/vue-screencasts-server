class Api::CommentsController < ApplicationController
  def create
    comment = Comment.create(comment_params)
    comment.user = current_user
    comment.save
    render json: comment_json(comment)
  end


  private

  def comment_params
    params.require(:comment).permit(:content, :video_id)
  end

  def comment_json(comments)
    CommentSerializer.new(comments).serializable_hash
  end
end
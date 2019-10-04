class Api::VideoTagsController < ApplicationController
  def create
    VideoTag.create(video_id: params[:video_id], tag_id: params[:tag_id])
    head 201
  end

  def delete
    VideoTag.find_by(video_id: params[:video_id], tag_id: params[:tag_id]).destroy
    head 204
  end
end

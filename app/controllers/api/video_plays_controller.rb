class Api::VideoPlaysController < ApplicationController
  def create
    VideoPlay.create(user_id: current_user.id, video_id: params[:video_id])
    head 201
  end
end

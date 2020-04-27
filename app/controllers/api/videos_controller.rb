class Api::VideosController < ApplicationController
  before_action :authenticate_user, only: [:create, :update, :destroy]

  def index
    videos = Video.all
    render json: video_json(videos)
  end

  def show
    video = Video.find(params[:id])
    render json: video_json(video)
  end

  def create
    video = Video.create(video_params)
    render json: video_json(video)
  end

  def destroy
    Video.find(params[:id]).destroy
    head 204
  end

  def update
    video = Video.find(params[:id])
    video.update(video_params)
    video.save()
    render json: video_json(video)
  end

  private

  def video_json(video)
    VideoSerializer.new(video, params: { user_pro: current_user && current_user.pro, user_admin: current_user && current_user.admin }).serializable_hash
  end

  def video_params
    params.require(:video).permit(:name, :description, :thumbnail, :videoUrl, :duration, :published_at, :code_summary, :order, :course_id, :pro, :lesson_type, :code, :code_summary_state)
  end
end

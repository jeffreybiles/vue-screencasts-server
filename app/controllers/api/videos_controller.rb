class Api::VideosController < ApplicationController
  before_action :authenticate_user, only: [:create, :update, :destroy]

  def index
    videos = Video.all
    render json: video_json(videos)
    # render json: videos.map { |v| basic_json(v) }
  end

  def show
    video = Video.find(params[:id])
    render json: video_json(video)
    # render json: basic_json(video)
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
    VideoSerializer.new(video, include: [:tags]).serializable_hash
  end

  def basic_json(video)
    {
      id: video.id,
      name: video.name,
      description: video.description,
      thumbnail: video.thumbnail,
      videoUrl: video.videoUrl,
      created_at: video.created_at,
      updated_at: video.updated_at
    }
  end

  def video_params
    params.require(:video).permit(:name, :description, :thumbnail, :videoUrl, :duration, :published_at, :code_summary)
  end
end

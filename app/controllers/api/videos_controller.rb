class Api::VideosController < ActionController::API
  def index
    videos = Video.all
    render json: VideoSerializer.new(videos, include: [:tags]).serializable_hash
  end

  def show
    video = Video.find(params[:id])
    render json: VideoSerializer.new(video, include: [:tags]).serializable_hash
  end
end

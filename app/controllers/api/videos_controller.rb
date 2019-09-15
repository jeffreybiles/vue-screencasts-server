class Api::VideosController < ActionController::API
  def index
    videos = Video.all
    render json: VideoSerializer.new(videos, include: [:tags]).serializable_hash
  end

  def show
    video = Video.find(params[:id])
    render json: VideoSerializer.new(video, include: [:tags]).serializable_hash
  end

  def create
    video = Video.create(video_params)
    render json: VideoSerializer.new(video, include: [:tags]).serializable_hash
  end

  private

  def video_params
    params.require(:video).permit(:name, :description, :thumbnail, :videoUrl)
  end
end

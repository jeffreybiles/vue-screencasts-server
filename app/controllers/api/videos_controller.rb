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

  def update_tags
    video_id = params["id"]
    new_tag_ids = params["tag_ids"]
    old_tag_ids = Video.find(video_id).tag_ids.map(&:to_s)

    added_tag_ids = new_tag_ids - old_tag_ids
    removed_tag_ids = old_tag_ids - new_tag_ids

    added_tag_ids.each do |tag_id|
      VideoTag.create(video_id: video_id, tag_id: tag_id)
    end
    removed_tag_ids.each do |tag_id|
      VideoTag.find_by(video_id: video_id, tag_id: tag_id).destroy
    end
  end

  private

  def video_json(video)
    VideoSerializer.new(video, include: [:tags]).serializable_hash
  end

  def video_params
    params.require(:video).permit(:name, :description, :thumbnail, :videoUrl)
  end
end

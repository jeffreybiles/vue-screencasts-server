class Api::TagsController < ApplicationController
  def create
    tag = Tag.create(name: params[:name])
    render json: TagSerializer.new(tag).serializable_hash
  end

  def index
    tags = Tag.all
    render json: TagSerializer.new(tags).serializable_hash
  end
end

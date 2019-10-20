class Api::TagsController < ApplicationController
  def create
    tag = Tag.create(name: params[:name])
    render json: TagSerializer.new(tag).serializable_hash
  end

  def show
    tag = Tag.find(params[:id])
    render json: TagSerializer.new(tag, include: [:videos, :'videos.tags']).serializable_hash
  end

  def index
    tags = Tag.all
    render json: TagSerializer.new(tags).serializable_hash
  end

  def update
    tag = Tag.find(params[:id])
    tag.name = params[:name]
    tag.save
    render json: TagSerializer.new(tag).serializable_hash
  end

  def destroy
    Tag.find(params[:id]).destroy
    head 204
  end
end

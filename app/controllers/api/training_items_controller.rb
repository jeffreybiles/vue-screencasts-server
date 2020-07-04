class Api::TrainingItemsController < ApplicationController
  before_action :authenticate_user, only: [:create, :update, :destroy]

  def create
    training_item = TrainingItem.create(item_params)
    render_item(training_item)
  end

  def update
    training_item = TrainingItem.find(params[:id])
    training_item.update_attributes(item_params)
    training_item.save
    render_item(training_item)
  end

  def destroy
    TrainingItem.find(params[:id]).destroy
    head 204
  end

  def render_item(items)
    render json: TrainingItemSerializer.new(items).serializable_hash    
  end

  def item_params
    params.require(:training_item).permit(:title, :position, :training_section_id, :text, :exercise_type, :vimeo_uid)
  end
end
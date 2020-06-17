class Api::TrainingItemsController < ApplicationController
  # before_action :authenticate_user, only: [:create, :update, :destroy]

  def create
    training_item = TrainingItem.create(section_params)
    render_module(training_item)
  end

  def update
    training_item = TrainingItem.find(params[:id])
    training_item.update_attributes(section_params)
    training_item.save
    render_section(training_item)
  end

  def destroy
    TrainingItem.find(params[:id]).destroy
    head 204
  end

  def render_section(modules)
    render json: TrainingItemSerializer.new(modules).serializable_hash    
  end

  def section_params
    params.require(:training_item).permit(:title, :position, :training_section_id, :text, :exercise_type)
  end
end
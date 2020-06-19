class Api::TrainingSectionsController < ApplicationController
  before_action :authenticate_user, only: [:create, :update, :destroy]

  def create
    training_section = TrainingSection.create(section_params)
    render_module(training_section)
  end

  def update
    training_section = TrainingSection.find(params[:id])
    training_section.update_attributes(section_params)
    training_section.save
    render_section(training_section)
  end

  def destroy
    TrainingSection.find(params[:id]).destroy
    head 204
  end

  def render_section(modules)
    render json: TrainingSectionSerializer.new(modules).serializable_hash    
  end

  def section_params
    params.require(:training_section).permit(:name, :position, :training_module_id)
  end
end
class Api::TrainingCompletionsController < ApplicationController
  def create
    TrainingCompletion.create(user_id: current_user.id, training_item_id: params[:training_item_id])
    head 201
  end
end

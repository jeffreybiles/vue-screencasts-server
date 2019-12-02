class Api::CoursesController < ApplicationController
  def create
    course = Course.create(course_params)
    render json: CourseSerializer.new(course).serializable_hash
  end

  def show
    course = Course.find(params[:id])
    render json: CourseSerializer.new(course, include: [:videos]).serializable_hash
  end

  def index
    courses = Course.all
    render json: CourseSerializer.new(courses).serializable_hash
  end

  def update
    course = Course.find(params[:id])
    course.update(course_params)
    course.save
    render json: CourseSerializer.new(course).serializable_hash
  end

  def destroy
    Course.find(params[:id]).destroy
    head 204
  end

  private

  def course_params
    params.require(:course).permit(:name, :description, :image_url, :series_type)
  end

end

class Api::CoursesController < ApplicationController
  def create
    course = Course.create(course_params)
    render json: course_json(course)
  end

  def show
    course = Course.find(params[:id])
    render json: CourseSerializer.new(course, include: [:videos]).serializable_hash
  end

  def index
    courses = Course.all
    render json: course_json(courses)
  end

  def update
    course = Course.find(params[:id])
    course.update(course_params)
    course.save
    render json: course_json(course)
  end

  def destroy
    Course.find(params[:id]).destroy
    head 204
  end

  def attach_video
    video = Video.find(params[:video_id])
    course = Course.find(params[:id])
    video.course_id = course.id
    video.order = course.max_order + 1
    video.save

    render json: VideoSerializer.new(video, include: [:course]).serializable_hash
  end

  def detach_video
    video = Video.find(params[:video_id])
    course = Course.find(params[:id])
    course.videos.delete(video)
    course.save
    render json: CourseSerializer.new(course).serializable_hash
  end

  private

  def course_json(courses)
    CourseSerializer.new(courses).serializable_hash
  end

  def course_params
    params.require(:course).permit(:name, :description, :image_url, :series_type)
  end

end

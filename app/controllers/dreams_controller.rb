class DreamsController < ApplicationController
  before_filter :authenticate_user!
  def new
    @dream = Dream.new
  end

  def create
    dream = Dream.create!(params[:dream])
    redirect_to dream
  end
  def edit
    @dream = Dream.find(params[:id])
  end

  def update
    dream = Dream.find(params[:id])
    dream.update_attributes(params[:dreams])
    redirect_to dream
  end

  def show
    @dream = Dream.find(params[:id])
  end

  def delete
    dream = Dream.find(params[:id])
    dream.destroy
    redirect_to dream_job_student_path
  end
end

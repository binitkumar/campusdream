class SubjectsController < ApplicationController
  before_filter :authenticate_user!
  def index
  end

  def new
    @subject = Subject.new
  end

  def create
    Subject.create!(params[:subject])
    redirect_to new_topic_path
  end

  def edit
  end
end

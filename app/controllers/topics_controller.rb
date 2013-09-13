class TopicsController < ApplicationController
  before_filter :authenticate_user!
  def index
  end

  def new
    @subjects = Subject.all
    @topic = Topic.new
  end

  def create
    Topic.create!(params[:topic])
    redirect_to new_study_material_path
  end

  def edit
  end
end

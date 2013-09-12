class ProjectsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @project = Project.new
  end

  def create
    Project.create(params[:project])
    redirect_to projects_technicals_path
  end

  def show
    @project = Project.find(params[:id])
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    project = Project.find(params[:id])
    project.udpate_attribute(params[:project])
  end

  def destroy
    project = Project.find(params[:id])
    project.destory
    redirect_to projects_technicals_path
  end

  def apply
    @project = Project.find(params[:id])
    @application = ProjectApplication.new
  end
end

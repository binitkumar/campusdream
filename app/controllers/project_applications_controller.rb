class ProjectApplicationsController < ApplicationController
  before_filter :authenticate_user!
  def create
    project_application = ProjectApplication.create(params[:project_application])
    redirect_to project_application.project
  end
end

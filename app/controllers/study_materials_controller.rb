class StudyMaterialsController < ApplicationController
  before_filter :authenticate_user!
  def new
    @study_material = StudyMaterial.new
    @topics = Topic.all
  end

  def create
    StudyMaterial.create!(params[:study_material])
    redirect_to study_material_admin_index_path
  end

  def show
    @study_material = StudyMaterial.find(params[:id])
  end

  def download
    @document = StudyMaterial.find(params[:id])
    Download.create!(
      user_id: current_user.id,
      study_material_id: @document.id
    )
    send_file @document.data.path, :type => @document.data_content_type, :disposition => 'inline'
  end

  def list
    render :json=> StudyMaterialsDatatable.new(view_context)
  end
end

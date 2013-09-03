class HomeController < ApplicationController
  def index
    if current_user && current_user.role == 'ADMIN'
      redirect_to controller: "admin", action: "index"
    elsif current_user && current_user.role == 'STUDENT'
      redirect_to controller: "student", action: "index"
    else
      render layout: "homepage"
    end
  end

  def study_material
    @study_materials = StudyMaterial.all
    render "student/study_material"
  end
end

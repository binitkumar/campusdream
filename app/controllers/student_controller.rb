class StudentController < ApplicationController
  def index
  end

  def study_material
    @study_materials = StudyMaterial.all
  end

  def mock_tests
    render "/admin/mock_tests"
  end

  def pd_articles
    render "/admin/pd_articles"
  end
end

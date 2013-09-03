class AdminController < ApplicationController
  def index
  end

  def study_material
    @study_materials = StudyMaterial.all
  end

  def pd_articles
    @pd_articles = PdArticle.all
  end
end

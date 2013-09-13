class AdminController < ApplicationController
  before_filter :authenticate_user!
  def index
  end

  def study_material
    @study_materials = StudyMaterial.all
  end

  def pd_articles
    @pd_articles = PdArticle.all
  end

  def campus_news
    @newses = News.all
  end
end

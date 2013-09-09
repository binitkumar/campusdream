class StudentController < ApplicationController
  before_filter :authenticate_user!, except: ['study_material', 'pd_articles', 'news', 'mock_tests']

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

  def test
    @tests = current_user.test_participations
  end

  def downloads
    @downloads = current_user.downloads
  end

  def news
    @newses = News.where(is_published: true)
  end
end

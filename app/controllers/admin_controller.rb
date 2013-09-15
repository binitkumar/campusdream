class AdminController < ApplicationController
  before_filter :authenticate_user!
  def index
    @sign_up_dates = Array.new
    @sign_up_count = Array.new
    User.count(:group => "date(created_at)").each do |key, value|
      @sign_up_dates.push key
      @sign_up_count.push value
    end
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title({ :text=>"Users chart"})
      f.options[:xAxis][:categories] = @sign_up_dates
      f.labels(:items=>[:html=>"Users sign up graph", :style=>{:left=>"40px", :top=>"8px", :color=>"black"} ])
      f.series(:type=> 'spline',:name=> 'Sign up count', :data=> @sign_up_count)
    end
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

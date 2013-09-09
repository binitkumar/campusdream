class NewsesController < ApplicationController
  before_filter :authenticate_user!
  def show
    @news = News.find(params[:id])
  end

  def new
    @news = News.new
  end

  def create
    news = News.create(params[:news])
    redirect_to campus_news_admin_index_path
  end

  def edit
    @news = News.find(params[:id])
  end

  def update
    news = News.find(params[:id])
    news.update_attributes(params[:news])
    redirect_to campus_news_admin_index_path
  end

  def destroy
    news = News.find(params[:id])
    news.destroy
    redirect_to campus_news_admin_index_path
  end
end

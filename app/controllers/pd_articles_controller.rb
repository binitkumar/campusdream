class PdArticlesController < ApplicationController

  def new
    @pd_article = PdArticle.new
  end

  def create
    PdArticle.create!(params[:pd_article])
    redirect_to pd_articles_admin_index_path
  end

  def list
    render :json=> PdArticlesDatatable.new(view_context)
  end

  def show
    @pd_article = PdArticle.find(params[:id])

    UserView.create!(
      user_id: current_user.id,
      article_id: @pd_article.id
    ) unless current_user.viewed(@pd_article)
  end

  def like
    @pd_article = PdArticle.find(params[:id])
    Like.create!(
      user_id: current_user.id,
      article_id: @pd_article.id
    ) unless current_user.liked(@pd_article)
    redirect_to pd_article_path(@pd_article)
  end

  def unlike
    @pd_article = PdArticle.find(params[:id])
    Like.where(
        user_id: current_user.id,
        article_id: @pd_article.id
    ).first.destroy
    redirect_to pd_article_path(@pd_article)
  end
end

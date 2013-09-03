class PdArticlesDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: PdArticle.count,
        iTotalDisplayRecords: pd_articles.total_entries,
        aaData: data
    }
  end

  private

  def data
    pd_articles.map do |pd_article|
      [
          link_to( columizer(pd_article.title), pd_article),
          h(pd_article.user_views.count),
          h(pd_article.likes.count),
          h(pd_article.created_at.strftime("%B %e, %Y"))
      ]
    end
  end

  def pd_articles
    @pd_articles ||= fetch_pd_articles
  end

  def fetch_pd_articles
    pd_articles = PdArticle.order("#{sort_column} #{sort_direction}")
    pd_articles = pd_articles.page(page).per_page(per_page)
    if params[:sSearch].present?
      pd_articles = pd_articles.where("name like :search or description like :search", search: "%#{params[:sSearch]}%")
    end
    pd_articles
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[title nil nil created_at ]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end

  def columizer value
    if value.length > 23
      sub_value = value[0..23] + ".."
    else
      value
    end
  end
end

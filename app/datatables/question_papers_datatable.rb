class QuestionPapersDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: QuestionPaper.count,
        iTotalDisplayRecords: question_papers.total_entries,
        aaData: data
    }
  end

  private

  def data
    question_papers.map do |question_paper|
      [
          link_to( columizer(question_paper.name), question_paper),
          h(question_paper.questions.count),
          h(question_paper.total_time),
          h(question_paper.created_at.strftime("%B %e, %Y"))
      ]
    end
  end

  def question_papers
    @question_papers ||= fetch_question_papers
  end

  def fetch_question_papers
    question_papers = QuestionPaper.order("#{sort_column} #{sort_direction}")
    question_papers = question_papers.page(page).per_page(per_page)
    if params[:sSearch].present?
      question_papers = question_papers.where("name like :search or description like :search", search: "%#{params[:sSearch]}%")
    end
    question_papers
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[name nil nil created_at ]
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

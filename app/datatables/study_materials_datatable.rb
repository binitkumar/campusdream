class StudyMaterialsDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: StudyMaterial.count,
        iTotalDisplayRecords: study_materials.total_entries,
        aaData: data
    }
  end

  private

  def data
    study_materials.map do |study_material|
      [
          link_to( columizer(study_material.name), study_material),
          h(study_material.topic.name),
          h(study_material.rating),
          h(study_material.created_at.strftime("%B %e, %Y")),
          link_to( "<img src='/assets/download.png' width=20 height=20 />".html_safe, study_material.data.url,:target=>"_blank")
      ]
    end
  end

  def study_materials
    @study_materials ||= fetch_study_materials
  end

  def fetch_study_materials
    study_materials = StudyMaterial.order("#{sort_column} #{sort_direction}")
    study_materials = study_materials.page(page).per_page(per_page)
    if params[:sSearch].present?
      study_materials = study_materials.where("name like :search or description like :search", search: "%#{params[:sSearch]}%")
    end
    study_materials
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[name nil rating created_at ]
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

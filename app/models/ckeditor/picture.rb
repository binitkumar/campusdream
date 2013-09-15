class Ckeditor::Picture < Ckeditor::Asset
  attr_accessor :processing
  has_attached_file :data,{
                      :url  => "/ckeditor_assets/pictures/:id/:basename.:extension",
                      :path => ":rails_root/public/ckeditor_assets/pictures/:id/:basename.:extension",
                    }.merge(PAPERCLIP_STORAGE_OPTIONS)

  validates_attachment_size :data, :less_than => 2.megabytes
  validates_attachment_presence :data

  def url_content
    url(:content)
  end

  def reprocess_photo
    # don't crop if the user isn't updating the photo
    #   ...or if the photo is already being processed
    return unless (cropping? && !processing)
    self.processing = true
    photo.reprocess!
    self.processing = false
  end
end

class StudyMaterial < ActiveRecord::Base
  attr_accessible :description, :name, :rating, :topic_id, :data
  has_attached_file :data,
                    :url => "/study_materials/:id/download",
                    :path => ":rails_root/uploads/:class/:id/:basename.:extension"
  belongs_to :topic
  has_many :downloads
  validates_presence_of :name, :topic_id
end

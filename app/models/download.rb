class Download < ActiveRecord::Base
  attr_accessible :study_material_id, :user_id

  belongs_to :user
  belongs_to :study_material
end

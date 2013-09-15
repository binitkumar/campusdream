class Dream < ActiveRecord::Base
  attr_accessible :achivement_process, :completion_time, :description, :title, :user_id

  belongs_to :user
end

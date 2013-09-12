class ProjectApplication < ActiveRecord::Base
  attr_accessible :joining_reason, :liked, :notes, :project_id, :user_id, :work_area
  belongs_to :project
  belongs_to :user
end

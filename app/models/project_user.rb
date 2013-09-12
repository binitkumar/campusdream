class ProjectUser < ActiveRecord::Base
  attr_accessible :joining_date, :project_id, :user_id
end

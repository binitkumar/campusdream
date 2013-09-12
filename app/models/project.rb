class Project < ActiveRecord::Base
  attr_accessible :description, :end_date, :name, :start_date
  has_many :project_users
  has_many :project_applications
end

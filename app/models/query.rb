class Query < ActiveRecord::Base
  attr_accessible :description, :subject, :user_id

  belongs_to :user
end

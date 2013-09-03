class News < ActiveRecord::Base
  attr_accessible :description, :is_published, :title, :user_id
end

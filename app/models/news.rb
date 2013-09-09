class News < ActiveRecord::Base
  attr_accessible :description, :is_published, :title, :user_id

  has_many :news_views
  has_many :users, through: :news_views
end

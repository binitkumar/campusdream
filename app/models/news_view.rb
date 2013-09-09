class NewsView < ActiveRecord::Base
  attr_accessible :news_id, :user_id
  belongs_to :user
  belongs_to :news
end

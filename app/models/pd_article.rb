class PdArticle < ActiveRecord::Base
  attr_accessible :description, :title, :video
  has_attached_file :video

  has_many :likes, foreign_key: :article_id
  has_many :user_views, foreign_key: :article_id
end

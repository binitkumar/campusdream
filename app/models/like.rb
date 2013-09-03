class Like < ActiveRecord::Base
  attr_accessible :article_id, :user_id

  belongs_to :user
  belongs_to :pd_article, primary_key: :article_id
end

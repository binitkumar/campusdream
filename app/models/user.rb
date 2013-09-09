class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :contact_no,
                  :college_name, :course_name, :stream, :year_of_joining, :role,
                  :uid, :name, :oauth_token, :oauth_expires_at, :provider
  # attr_accessible :title, :body
  acts_as_messageable

  has_many :student_answers
  has_many :test_participations
  has_many :user_views
  has_many :likes
  has_many :queries
  has_many :downloads
  has_many :news_views

  def mailboxer_email(object)
    self.email
  end

  def mailboxer_name
    self.name
  end

  def self.site_admins
    where(role: ADMIN)
  end

  def has_participated?(question_paper_id)
    test_participations.where(question_paper_id: question_paper_id).length != 0
  end

  def viewed(pd_article)
    user_views.map(&:article_id).include?(pd_article.id)
  end

  def liked(pd_article)
    likes.map(&:article_id).include?(pd_article.id)
  end
end

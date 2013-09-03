class StudentAnswer < ActiveRecord::Base
  attr_accessible :answer, :question_id, :user_id

  belongs_to :question
  belongs_to :user
end

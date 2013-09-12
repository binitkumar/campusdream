class Interview < ActiveRecord::Base
  attr_accessible :description, :name, :interview_questions_attributes

  has_many :interview_questions
  accepts_nested_attributes_for :interview_questions, allow_destroy: true
end

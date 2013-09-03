class Question < ActiveRecord::Base
  attr_accessible :answer_1, :answer_2, :answer_3, :answer_3, :answer_4, :correct_answer, :question_paper_id, :title,
    :position

  belongs_to :question_paper
  has_many :student_answers

  def selected_answer(user_id)
    student_answers.where(user_id: user_id).first
  end
end

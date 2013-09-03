class QuestionPaper < ActiveRecord::Base
  attr_accessible :description, :name, :weitage

  has_many :questions

  def total_time
    questions.count * weitage if weitage
  end

  def get_questions(position)
    self.questions.where(:position=>position).first
  end

  def score(user_id)
    total = 0
    questions.each do |ques|
      if ques.selected_answer(user_id) && ques.selected_answer(user_id).answer.to_i == ques.correct_answer.to_i
        total += 1
      end
    end
    total
  end
end

class TestParticipation < ActiveRecord::Base
  attr_accessible :question_paper_id, :score, :time_consumed, :user_id

  belongs_to :question_paper
  belongs_to :user

  def self.current_participation(question_paper_id,user_id)
    where(
      question_paper_id: question_paper_id,
      user_id: user_id
    ).first
  end

  def percentile
    lesser_count  = 0

    question_paper.test_participations.each do |participation|
      lesser_count += 1 if score >= participation.score
    end
    ( lesser_count.to_f / question_paper.test_participations.length.to_f ) * 100
  end
end

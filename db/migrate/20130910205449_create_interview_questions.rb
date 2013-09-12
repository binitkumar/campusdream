class CreateInterviewQuestions < ActiveRecord::Migration
  def change
    create_table :interview_questions do |t|
      t.integer :interview_id
      t.text :question
      t.text :answer
      t.integer :position

      t.timestamps
    end
  end
end

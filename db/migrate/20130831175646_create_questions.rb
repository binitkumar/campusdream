class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.string :answer_1
      t.string :answer_2
      t.string :answer_3
      t.string :answer_3
      t.string :answer_4
      t.string :correct_answer
      t.integer :question_paper_id

      t.timestamps
    end
  end
end

class CreateStudentAnswers < ActiveRecord::Migration
  def change
    create_table :student_answers do |t|
      t.integer :user_id
      t.integer :question_id
      t.integer :answer

      t.timestamps
    end
  end
end

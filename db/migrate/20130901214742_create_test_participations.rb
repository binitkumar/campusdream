class CreateTestParticipations < ActiveRecord::Migration
  def change
    create_table :test_participations do |t|
      t.integer :user_id
      t.integer :question_paper_id
      t.string :time_consumed
      t.integer :score

      t.timestamps
    end
  end
end

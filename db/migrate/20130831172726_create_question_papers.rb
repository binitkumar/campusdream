class CreateQuestionPapers < ActiveRecord::Migration
  def change
    create_table :question_papers do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end

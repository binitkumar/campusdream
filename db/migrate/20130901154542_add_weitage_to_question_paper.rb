class AddWeitageToQuestionPaper < ActiveRecord::Migration
  def change
    add_column :question_papers, :weitage, :integer
  end
end

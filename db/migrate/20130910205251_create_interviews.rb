class CreateInterviews < ActiveRecord::Migration
  def change
    create_table :interviewes do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end

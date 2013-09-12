class CreateProjectApplications < ActiveRecord::Migration
  def change
    create_table :project_applications do |t|
      t.integer :project_id
      t.text :liked
      t.text :joining_reason
      t.text :work_area
      t.integer :user_id
      t.text :notes

      t.timestamps
    end
  end
end

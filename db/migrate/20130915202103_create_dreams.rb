class CreateDreams < ActiveRecord::Migration
  def change
    create_table :dreams do |t|
      t.integer :user_id
      t.string :title
      t.text :description
      t.string :completion_time
      t.text :achivement_process

      t.timestamps
    end
  end
end

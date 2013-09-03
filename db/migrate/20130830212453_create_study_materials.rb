class CreateStudyMaterials < ActiveRecord::Migration
  def change
    create_table :study_materials do |t|
      t.string :name
      t.text :description
      t.integer :topic_id
      t.decimal :rating
      t.attachment :data

      t.timestamps
    end
  end
end

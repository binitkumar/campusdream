class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.string :subject
      t.text :description
      t.integer :user_id

      t.timestamps
    end
  end
end

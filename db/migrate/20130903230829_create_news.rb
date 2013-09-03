class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :title
      t.text :description
      t.integer :user_id
      t.boolean :is_published

      t.timestamps
    end
  end
end

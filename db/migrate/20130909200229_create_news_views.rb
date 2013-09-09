class CreateNewsViews < ActiveRecord::Migration
  def change
    create_table :news_views do |t|
      t.integer :user_id
      t.integer :news_id

      t.timestamps
    end
  end
end

class CreatePdArticles < ActiveRecord::Migration
  def change
    create_table :pd_articles do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end

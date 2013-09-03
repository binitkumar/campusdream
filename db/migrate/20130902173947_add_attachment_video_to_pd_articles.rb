class AddAttachmentVideoToPdArticles < ActiveRecord::Migration
  def self.up
    change_table :pd_articles do |t|
      t.attachment :video
    end
  end

  def self.down
    drop_attached_file :pd_articles, :video
  end
end

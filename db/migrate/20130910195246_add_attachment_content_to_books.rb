class AddAttachmentContentToBooks < ActiveRecord::Migration
  def self.up
    change_table :books do |t|
      t.attachment :content
    end
  end

  def self.down
    drop_attached_file :books, :content
  end
end

class Book < ActiveRecord::Base
  attr_accessible :description, :name, :content, :category, :published

  has_attached_file :content, {}.merge(PAPERCLIP_STORAGE_OPTIONS)
end

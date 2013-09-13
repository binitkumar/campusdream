class Book < ActiveRecord::Base
  attr_accessible :description, :name, :content, :category

  has_attached_file :content, {}.merge(PAPERCLIP_STORAGE_OPTIONS)
end

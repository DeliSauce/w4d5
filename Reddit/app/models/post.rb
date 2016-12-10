class Post < ActiveRecord::Base

  validates :title, :sub_id, :author_id, presence: true

  
end

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  validates :content, length: { minimum: 2, maximum: 300 }
end

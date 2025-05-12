class Comment < ApplicationRecord
  belongs_to :document
  #validates :user_id, presence: true
  validates :content, presence: true
end

class Comment < ApplicationRecord
  belongs_to :document
  belongs_to :user

  #validates :user_id, presence: true
  validates :content, presence: true
end

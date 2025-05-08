class Document < ApplicationRecord
  belongs_to :user
  #has_many :comments, dependent: :destroy
  
  has_one_attached :file 
  
  validates :title, :category, presence: true
end

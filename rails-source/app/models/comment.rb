class Comment < ApplicationRecord
  belongs_to :article
  validates :commenter, presence: true, length: { maximum: 60 }
  validates :body, presence: true, length: { maximum: 2000 }
end

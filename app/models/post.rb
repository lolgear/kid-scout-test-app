class Post < ApplicationRecord

  validates :title, presence: true
  validates :body, presence: true
  has_many :comments, dependent: :destroy

  scope :available, -> { where(draft: false) }

end

class Post < ApplicationRecord
  belongs_to :user

  validates :title, :body, presence: true

  scope :published, -> { where(published: true) }
end

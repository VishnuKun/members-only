class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  validates :title, :body, presence: true, length: { minimum: 1 }

  def self.search(query)
    title_matches = where('title LIKE ?', "%#{query}%")
    body_matches = where('body LIKE ?', "%#{query}%")

    title_matches + (body_matches - title_matches)
  end
end

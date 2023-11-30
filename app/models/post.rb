class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  validates :title, :body, presence: true, length: { minimum: 1 }

  def self.search(query)
    where('title LIKE ?', "%#{query}%")
  end
end

class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  validates :title, presence: true
  validates :body, presence: true
  validates :body, length: {maximum: 200}

  def self.search(search,search_way)
    if search
      if search_way=="complete"
        return Book.where(["title LIKE ?", "#{search}"])
      elsif search_way=="forward"
        return Book.where(["title LIKE ?", "#{search}%"])
      elsif search_way=="backward"
        return Book.where(["title LIKE ?", "%#{search}"])
      else
        return Book.where(["title LIKE ?", "%#{search}%"])
      end
    else
      return Book.all
    end
  end
end

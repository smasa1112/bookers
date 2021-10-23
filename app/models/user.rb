class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutabl  e, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_books, through: :favorites, source: :book
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

  attachment :profile_image
  
  validates :name, uniqueness: true
  validates :name, length: {in:2..20}
  validates :introduction, length: {maximum: 50}

  # RelationshipsはUser同士の中間テーブルなので以下の書き方で示す
  # 被フォロー側の関係
  has_many :reverse_of_relationshiops, class_name:"Relationship", foreign_key: "follow_id", dependent: :destroy
  # 与フォロー側の関係
  has_many :relationships, class_name:"Relationship", foreign_key:"follower_id", dependent: :destroy
  # 被フォロー関係を通じて参照→自分をフォローしている人
  has_many :followers, through: :reverse_of_relationshiops, source: :follower
  # 与フォロー関係を通じて参照→自分がフォローしている人
  has_many :follows, through: :relationships, source: :follow

  def follow(user_id)
    relationships.create(follow_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(follow_id: user_id).destroy
  end

  def follow?(user)
    follows.include?(user)
  end
  
  def followed_by?(user)
    relationships.where(user_id: user.id).exists?
  end
  
  

  # User.{}みたいな感じで使いたいときにはself.{}とする
  def self.search(search,search_way)
    if search
      if search_way=="complete"
        return User.where(["name LIKE ?", "#{search}"])
      elsif search_way=="forward"
        return User.where(["name LIKE ?", "#{search}%"])
      elsif search_way=="backward"
        return User.where(["name LIKE ?", "%#{search}"])
      else
        return User.where(["name LIKE ?", "%#{search}%"])
      end
    else
      return User.all
    end
  end
end

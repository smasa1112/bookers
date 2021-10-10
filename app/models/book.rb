class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  validates :title, presence: true
  validates :body, presence: true
  validates :body, length: {maximum: 200}

  def self.last_week_rank
    #これだと一週間以内のものしか取ってこれないのでダメ#一週間前のものを1それ以外を0とするようなパラメータが必要そう
    #return self.joins(:favorites).where(likes: { created_at: 1.week.ago.beginning_of_day .. Time.zone.now.end_of_day}).group(:id).order("count(*) desc")
    # いいねが1週間いないのものは1それ以外は0として合計を算出するSQL文->created_atの比較ができないためだめ
    to  = Time.current.at_end_of_day
    from  = (to - 6.day).at_beginning_of_day
    return self.includes(:favorited_users).
      sort {|a,b| 
        b.favorited_users.includes(:favorites).where(created_at: from...to).size <=> 
        a.favorited_users.includes(:favorites).where(created_at: from...to).size
      }
    #return self.includes(:favorited_users).sort{|a,b| b.favorited_users.size <=> a.favorited_users.size}
  end

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

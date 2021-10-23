class Group < ApplicationRecord
  has_many:group_users, dependent: :destroy

  validates :name, presence: true
  attachment :image

  def user_join?(user)
    return group_users.where(user_id: user.id).exists?
  end
end

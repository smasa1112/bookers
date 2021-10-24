class Group < ApplicationRecord
  has_many:group_users, dependent: :destroy
  has_many:users, through: :group_users


  validates :name, presence: true
  attachment :image

  def user_join?(user)
    return group_users.where(user_id: user.id).exists?
  end
end

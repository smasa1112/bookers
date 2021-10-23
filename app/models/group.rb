class Group < ApplicationRecord
  has_many:group_users, dependent: :destroy
  
  validates :name, presence: true
  attachment :image
end

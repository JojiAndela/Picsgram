class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  validates :follower_id, presence: true
 validates :followed_id, presence: true

 def not_self
       errors.add(:followed, "can't be equal to follower") if follower == followed
end
end

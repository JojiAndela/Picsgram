class User < ApplicationRecord

  has_many :pics, dependent: :destroy
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :pics, through: :likes
  has_many :chatroom_users
  has_many :chatrooms, through: :chatroom_users
  has_many :messages
  has_many :notifications, foreign_key: :recipient_id
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, :default_url => "/images/100.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :friend_requests, dependent: :destroy
  has_many :pending_requests, class_name: "FriendRequest", foreign_key: :friend_id
  has_many :pending_friends, through: :friend_requests, source: :friend

  has_many :active_relationships, class_name:  "Relationship",
                                    foreign_key: "follower_id",
                                    dependent:   :destroy

  has_many :passive_relationships, class_name:  "Relationship",
                                    foreign_key: "followed_id",
                                    dependent:   :destroy

  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower


  validates :username, presence: true, length: { maximum: 50 }



  def like!(pic)
    self.likes.create(pic_id: pic.id)
    Notification.create(recipient: pic.user, actor: self, action: "liked your", notifiable: pic)

  end

  def unlike!(pic)
    like = self.likes.find_by_pic_id(pic.id)
    Notification.create(recipient: pic.user, actor: self, action: "unliked your", notifiable: pic)

    like.destroy!

  end

  def like?(pic)
    self.likes.find_by_pic_id(pic.id)
  end
  def name
    "#{firstname} #{lastname}"
  end
  def remove_friend(friend)
  friends.destroy(friend)
  end

  # Follows a user.
  def follow(other_user)
    following << other_user
  end

  # Unfollows a user.
  def unfollow(other_user)
    following.delete(other_user)
  end
  #users feed according followings
  def feed
    following_ids = "SELECT followed_id FROM relationships
    WHERE  follower_id = :user_id"
    Pic.where("user_id IN (#{following_ids})
    OR user_id = :user_id", user_id: id)
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

end

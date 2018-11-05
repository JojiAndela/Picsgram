class Pic < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes

  def mentions
    @mentions ||= begin
      regex = /@([\w]+)/
      caption.scan(regex).flatten
    end
  end

  def mentioned_users
    @mentioned_users ||= User.where(username: mentions)
  end
  has_attached_file :image, :default_url => "/images/100.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end

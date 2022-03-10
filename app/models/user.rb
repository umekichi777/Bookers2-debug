class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :user_rooms, dependent: :destroy

  # 自分がフォローする側の関係性
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 自分がフォローしている人　（一覧画面などで使う　user.followings）
  has_many :followings, through: :relationships, source: :followed

  # 自分がフォローされる側の関係性
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 自分をフォローしている人　（一覧画面などで使う　user.followers）
  has_many :followers, through: :reverse_of_relationships, source: :follower

  has_many :group_users
  has_many :groups, through: :group_users


  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }



  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end


  # フォローしたときの処理
  def follow(user)
    relationships.create(followed_id: user.id)
  end
  # フォローを外したときの処理
  def unfollow(user)
    relationships.find_by(followed_id: user.id).destroy
  end
  # フォローしているかの判定
  def following?(user)
    followings.include?(user)
  end


  def self.search_for(search, word)
    if search == "perfect_match"
      User.where(name: word)
    elsif search == "forward_match"
      User.where("name LIKE?", word+'%')
    elsif search == "backward_match"
      User.where("name LIKE?", '%'+word)
    else
      User.where("name LIKE?", '%'+word+'%')
    end
  end
end

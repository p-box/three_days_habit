class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 12 }
  validates :comment, length: { maximum: 250 }
  
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  #わりやすい名前, 参照したいテーブル, 参照する外部キー,userに紐づいたカラムを削除
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
  #一覧画面でuser.followersなどと記述するため, throughでスルーするテーブル, sourceで参照するカラムを指定

  has_many :posts, dependent: :destroy

  # フォローした時の処理
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  # フォローを外した時の処理
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  # フォローしているか判定
  def following?(user)
    followings.include?(user)
  end

  # 検索方法分岐
  def self.looks(condition, word)
    if condition == "perfect_match"
      @user = User.where('name LIKE?', "#{word}")
    elsif condition == "forward_match"
      @user = User.where('name LIKE?', "#{word}%")
    elsif condition == "backward_match"
      @user = User.where('name LIKE?', "%#{word}")
    elsif condition == "partial_match"
      @user = User.where('name LIKE?', "%#{word}%")
    else
      @user = User.all
    end
  end
      

end

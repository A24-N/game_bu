class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
# マッチング機能
  has_many :messages, dependent: :destroy
  has_many :matches, dependent: :destroy
  # has_one :rooms, through: :matches, dependent: :destroy
  has_one :rooms_owner, class_name: "Room", foreign_key: "owner_id", dependent: :destroy
  has_one :rooms_member, class_name: "Room", foreign_key: "member_id", dependent: :destroy
#ルームで各ユーザー情報を表示
  has_many :owner, through: :matches, source: :owner_id
  has_many :member, through: :matches, source: :member_id
#フォロー関係
  has_many :relationships, class_name: "Relationship", foreign_key: "follow_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
#フォロー関係一覧画面
  has_many :followings, through: :relationships, source: :follower
  has_many :followers, through: :reverse_of_relationships, source: :follow
#紹介文関係
  has_many :from_introduces, class_name: "Introduce", foreign_key: "introduce_from_user_id", dependent: :destroy
  has_many :to_introduces, class_name: "Introduce", foreign_key: "introduce_to_user_id", dependent: :destroy

  has_one_attached :image
  enum playstyle: {empty: 0, enjoy: 1, hard: 2}

# プロフィール画像登録時の処理
  def get_image(width, height)
    unless image.attached?
      file_path =Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

#フォローしたときの処理
  def follow(user_id)
    relationships.create(follower_id: user_id)
  end
#フォローを外すときの処理
  def unfollow(user_id)
    relationships.find_by(follower_id: user_id).destroy
  end
#フォローしているかの判定
  def following?(user)
    followings.include?(user)
  end

#guest機能
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.nickname = "ゲストユーザー"
      user.role = 2
    end
  end
end
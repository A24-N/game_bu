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

  has_one_attached :image

  enum playstyle: {empty: 0, enjoy: 1, hard: 2}
  enum matching_status: {afk: 0, stand_by: 1, in_action: 2 }

# プロフィール画像登録時の処理
  def get_image(width, height)
    unless image.attached?
      file_path =Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

# マッチングステータス切替の処理
  def status_change
    if self.matching_status == "afk"
      self.update(matching_status: 1)
      @room = Room.new
      @match = Match.new
      @room.user_id = self.id
      @room.save
      @match.room_id = @room.id
      @match.user_id = self.id
      @match.save
    elsif self.matching_status == "stand_by"
      self.update(matching_status: 0)
      @room = Room.find_by(user_id: self.id)
      @match = Match.find_by(user_id: self.id)
      @room.destroy
      @match.destroy
    end
  end
end

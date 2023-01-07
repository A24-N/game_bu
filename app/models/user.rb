class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

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

end

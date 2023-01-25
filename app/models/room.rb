class Room < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :matches, dependent: :destroy

  belongs_to :owner, class_name: "User"
  belongs_to :member, class_name: "User"
end

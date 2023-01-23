class Introduce < ApplicationRecord
  belongs_to :introduce_from_user, class_name: "User"
  belongs_to :introduce_to_user, class_name: "User"

  validates :body, presence:true, length:{maximum:300}
end

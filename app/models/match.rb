class Match < ApplicationRecord

  belongs_to :user
  belongs_to :room, optional: true

  enum matching_status: {afk: 0, stand_by: 1, in_action: 2 }

end

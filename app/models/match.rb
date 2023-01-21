class Match < ApplicationRecord

  belongs_to :user
  belongs_to :room, optional: true

  validates :game_name, presence:true
  validates :game_hard, presence:true
  validates :room_comment, presence:true,length:{maximum:200}

  enum matching_status: {afk: 0, stand_by: 1, in_action: 2 }

end

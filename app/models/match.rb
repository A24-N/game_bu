class Match < ApplicationRecord
  belongs_to :user
  belongs_to :room, optional: true

  validates :game_name, presence:true
  validates :game_hard, presence:true
  validates :room_comment, presence:true,length:{maximum:200}

  enum matching_status: {afk: 0, stand_by: 1, in_action: 2 }

  def push(owner)
    params = {"app_id" => ENV['OneSignal_key'],
              "contents" => {'en' => 'matched', 'ja' => 'マッチングしました!!'},
              "include_player_ids" => [owner.user.onesignal_user_id]
            }
    uri = URI.parse('https://onesignal.com/api/v1/notifications')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.path,'Content-Type'  => 'application/json;charset=utf-8')
    request.body = params.as_json.to_json
    response = http.request(request)
    puts response.body
  end
end

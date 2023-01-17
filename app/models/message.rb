class Message < ApplicationRecord

  belongs_to :user
  belongs_to :room
  
  validates :chat, presence: true
  after_create_commit { MessageBroadcastJob.perform_later self }
  
end

class MessageBroadcastJob < ApplicationJob
  # queue_as :default
  def perform(message)
    room = Room.find(message.room_id)
    owner = room.owner
    member = room.member
    current_user = User.find(message.user_id)
    ActionCable.server.broadcast "room_channel_#{message.room_id}", {message: render_message(message, owner, member, room, current_user)}
  end

  private

    def render_message(message, owner, member, room, current_user)
      ApplicationController.renderer.render partial: 'messages/message', locals: { message: message, room: room, owner: owner, member: member, current_user: current_user }
    end
end

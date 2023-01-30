class MessageBroadcastJob < ApplicationJob
  # queue_as :default

  # def perform(message)
  #   current_user = User.find(message.user_id)
  #   # current_user = find_verified_user
  #   binding.pry
  #   room = message.room
  #   owner = room.owner
  #   member = room.member
  #   ActionCable.server.broadcast "room_channel_#{message.room_id}", {message: render_message(message, current_user, owner, member)}
  # end

  # private

  #   def render_message(message, current_user, owner, member)
  #     ApplicationController.renderer.render partial: 'messages/message', locals: { message: message, current_user: current_user, owner: owner, member: member }
  #   end
end

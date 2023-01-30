class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel_#{params['room']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    record = Message.create! chat: data['message'], user_id: current_user.id, room_id: params['room']
    ActionCable.server.broadcast("room_channel_#{params['room']}", {message: render_message(record)})
  end

  private

  def render_message(record)
    ApplicationController.renderer.render(partial: 'messages/message', locals: {message: record})
  end

end

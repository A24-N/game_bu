import consumer from "./consumer"

$(document).on('turbolinks:load', function () {

  const messages = $('#messages')

  const room = consumer.subscriptions.create( {
                  channel: 'RoomChannel',
                  room: $('#messages').data('room_id'),
              }, {
    connected() {
      // un used
    },

    disconnected() {
      // un used
    },

    received(data) {
      messages.append(data['message'])
    },

    speak: function (message) {
      return this.perform('speak', {message: message})
    },

  })

  $(document).on('keypress', '[data-behavior~=room_speaker]', function(event) {
    if (event.keyCode === 13) {
      room.speak(event.target.value);
      event.target.value = '';
      return event.preventDefault();
    }
  });

})
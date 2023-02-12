window.OneSignal = window.OneSignal || [];
  OneSignal.push(function() {
    OneSignal.init({
      appId: gon.OneSignal_key,
      notifyButton: {
        enable: true,
      }
    });
  });
OneSignal.push(function() {
  OneSignal.on('subscriptionChange', function (isSubscribed) {
    OneSignal.getUserId(function(userId) {

　　　　　// 登録した時の処理
      if (isSubscribed) {
        $.ajax({
          url:'/onesignal/<%= current_user.id %>/add',
          type: 'POST',
          data: {
            onesignal_user_id: userId,
          }
        });

　　　　　// 解除した時の処理
      } else {
        $.ajax({
          url:'/onesignal/<%= current_user.id %>/add',
          type: 'POST',
          data: {
            onesignal_user_id: userId,
          }
        });
      }

    });
  });
});
csrf_token = $('meta[name=csrf-token]').attr('content');
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
          url: gon.OneSignal_add_url,
          type: 'POST',
          data: {
            onesignal_user_id: userId,
            authenticity_token: csrf_token,
          }
        });

　　　　　// 解除した時の処理
      } else {
        $.ajax({
          url: gon.OneSignal_remove_url,
          type: 'POST',
          data: {
            onesignal_user_id: userId,
            authenticity_token: csrf_token,
          }
        });
      }

    });
  });
});
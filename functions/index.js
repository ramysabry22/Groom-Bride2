const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();
// *****************************************************************


//*******************************************************

   exports.sendAdminNotification = functions.database.ref('/SendPushNotificationNode/{pushId}').onWrite(event => {
   const news = event.after.val();
  // var fcmToken = "dfeZ7cACl0U:APA91bHPuXGqm9uhK1RDP8W179RMVYh-VzAVPqRkUg698ydSnyY0LJkuSuj9mDUp7ho5IKMPn5_qBaC6Ii11SLxXmNmYVrLmKyJDNmbWkTOLTbaMdduqvcpeCWZmtNKlz9jSVtk2xhQu";

        const payload = {notification: {
            title: `${news.title}`,
            body: `${news.body}`,
            sound: 'default'
            }
        };
//----
    // return admin.messaging().sendToDevice(fcmToken, payload)
    //     .then(function(response) {
    //       // the contents of response.
    //       console.log("Successfully sent message:", response);
    //     })
    //     .catch(function(error) {
    //       console.log("Error sending message:", error);
    //     });
//----
   return admin.messaging().sendToTopic("highScores",payload)
       .then(function(response){
            console.log('Notification sent successfully:',response);
       })
       .catch(function(error){
            console.log('Notification sent failed:',error);
       });

   });

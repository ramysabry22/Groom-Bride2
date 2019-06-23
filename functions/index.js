
const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();


   exports.sendAdminNotification = functions.database.ref('/PushNotificationsNode/{pushId}').onWrite(event => {
   const news = event.after.val();

        const payload = {notification: {
            title: `${news.title}`,
            body: `${news.body}`,
            sound: 'default',
            badge: '1'
            }
        };

   return admin.messaging().sendToTopic("GroomAndBrideNews",payload)
       .then(function(response){
            console.log('Notification sent successfully:',response);
       })
       .catch(function(error){
            console.log('Notification sent failed:',error);
       });

   });


var admin = require("firebase-admin");

var serviceAccount = require("/home/catalinzaharia/Development/Flutter/StudHub-Mobile/lib/api/studhub-340123-firebase-adminsdk-90ehg-b8e45ad773.json");

admin.initializeApp({
     credential: admin.credential.cert(serviceAccount),
     databaseURL: "https://studhub-340123-default-rtdb.europe-west1.firebasedatabase.app"
});

var token = "cmZ3Zn1jQravgTPY0LSOJa:APA91bH5UwWLqvkDK5mzlt5eLZCwVXNrWPpnxKQzdooPR8Xz1RB-qLsYPz3ULLUpqljIEoJSnho8nMMt_C80mE5RyH1Lu9Ab5fADPlWP4hMHtwAtHsAtMVayO-sR6ATcJcSX4A9vAXpi";

const message = {
     data: {
          score: '850',
          time: '2:45'
     },
     token: token
};

admin.messaging().getMessaging().send(message)
     .then((response) => {
          // Response is a message ID string.
          console.log('Successfully sent message:', response);
     })
     .catch((error) => {
          console.log('Error sending message:', error);
     });
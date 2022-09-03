
var admin = require("firebase-admin");

var serviceAccount = require("/home/catalinzaharia/Development/Flutter/StudHub-Mobile/lib/functions/studhub-340123-firebase-adminsdk-90ehg-4c7db70710.json");

admin.initializeApp({
     credential: admin.credential.cert(serviceAccount),
     databaseURL: "https://studhub-340123-default-rtdb.europe-west1.firebasedatabase.app"
});

var registrationToken = "cmZ3Zn1jQravgTPY0LSOJa:APA91bH5UwWLqvkDK5mzlt5eLZCwVXNrWPpnxKQzdooPR8Xz1RB-qLsYPz3ULLUpqljIEoJSnho8nMMt_C80mE5RyH1Lu9Ab5fADPlWP4hMHtwAtHsAtMVayO-sR6ATcJcSX4A9vAXpi";

const db = admin.firestore();
const messaging = admin.messaging();

topic = "zVaCiLINlqNrWLCVT3aP";
roomId = "zVaCiLINlqNrWLCVT3aP";

function sendNotificationForNewMessage (userName, text) {
     messaging.sendToTopic(topic, {
          notification: {
               title: userName,
               body: text
          },
     })
          .then((response) => {
               console.log('Successfully sent message:', response);
          })
          .catch((error) => {
               console.log('Error sending message:', error);
          });
};

const query = db.collection('rooms').doc(roomId).collection("messages");

const observer = query.onSnapshot(querySnapshot => {
     if (querySnapshot.docChanges()) {
          const message = db.collection('rooms').doc(roomId).collection("messages").orderBy("sentAt", "asc").get();
          const ref = message.then((response) => {
               var lastMessage = response.docs[response.size - 1].data();
               sendNotificationForNewMessage(lastMessage.uid, lastMessage.text);
          })
     }
}, err => {
     console.log(`Encountered error: ${err}`);
});

const admin = require('firebase-admin');
const functions = require('firebase-functions');
const { schedule } = require('firebase-functions/lib/providers/pubsub');
admin.initializeApp();
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
// exports.makeUppercase = functions.database.ref('/notify/{pushId}/original')
//   .onCreate((snapshot, context) => {
//     const original = snapshot.val();
//     console.log('Uppercasing', context.params.pushId, original);
//     const uppercase = original.toUpperCase();
//     return snapshot.ref.parent.child('uppercase').set(uppercase);
//   });

exports.sendNotification = functions.database
  .ref("/notify/{pushId}").onCreate((event) => {
    // Send notifications with FCM...
    console.log("get event", event);

    return admin.messaging().sendToTopic('alarm', {
      notification: {
        title: event._data.name,
        body: event._data.id,
      },
    });
  })

// exports.scheduledFunction = functions.pubsub.schedule('every 5 minutes').onRun((context) => {
//   console.log('This will be run every 5 minutes!');
//   return null;
// });
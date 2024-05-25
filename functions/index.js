const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.sendNotificationOnDataChange = functions.database.ref("/sensor_data")
    .onCreate((snapshot, context) => {
      const payload = {
        notification: {
          title: "Peringatan",
          body: "Terjadi gerakan mencurigakan di sekitar kandang Anda!",
        },
      };
      const deviceTokenRef = admin.database().ref("/Users/1/token");
      return deviceTokenRef.once("value").then((snapshot) => {
        const deviceToken = snapshot.val();
        if (deviceToken) {
          return admin.messaging().sendToDevice(deviceToken, payload);
        } else {
          console.log("Device token not found in database");
          return null;
        }
      }).catch((error) => {
        console.error("Error retrieving device token:", error);
        return null;
      });
    });

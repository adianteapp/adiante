// Import the functions you need from the SDKs you need
import { initializeApp  } from "firebase/app";
import {getMessaging,getToken,onMessage} from "firebase/messaging"


const firebaseConfig = {
  apiKey: "AIzaSyCZGxS2go_5XmLuusU3SNBliwIWCxG6etA",
  authDomain: "adiante2023.firebaseapp.com",
  projectId: "adiante2023",
  storageBucket: "adiante2023.appspot.com",
  messagingSenderId: "363415157506",
  appId: "1:363415157506:web:8f07f04ea43a88d818e01b" 
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const messaging = getMessaging(app);

// Callback for online incoming messages. Called when:
onMessage(messaging, (payload) => {
  console.log('Message received. ', payload);
  // ...
});

Notification.requestPermission().then(permission => {
  if (permission === 'granted') {
    getToken(messaging, {  vapidKey: 'BDFh4hD4NesXnlkDQWDvZ8-P2nk739rg3YJeNpNYxIJwYKGb-eMPqRBmYmh1OB_w4xyWy6amvaqU5sLWsNgq8hg' })
      .then((currentToken) => {
        if (currentToken) {
          // Send the token to your server and update the UI if necessary
          // ...
        } else {
          // Show permission request UI
          console.log('No registration token available. Request permission to generate one.');
          // ...
        }
      }).catch((err) => {
        console.log('An error occurred while retrieving token. ', err);
        // ...
      });
  } else {
    console.log('Unable to get permission to notify.');
  }
});
export default messaging;
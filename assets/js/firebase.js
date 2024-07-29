import { initializeApp } from "https://www.gstatic.com/firebasejs/10.12.4/firebase-app.js";
import { getDatabase } from "https://www.gstatic.com/firebasejs/10.12.4/firebase-database.js";

// Your web app's Firebase configuration
const firebaseConfig = {
  apiKey: "AIzaSyBh17nbtOsqmN0LV84BeBp_Rso1XPqv7VM",
  authDomain: "bookingevents-5db77.firebaseapp.com",
  projectId: "bookingevents-5db77",
  storageBucket: "bookingevents-5db77.appspot.com",
  messagingSenderId: "768081108112",
  appId: "1:768081108112:web:c9ca975b48acd162f6cc15"
};

firebase.initializeApp(firebaseConfig);

const database = firebase.database();
const storageRef = firebase.storage().ref();
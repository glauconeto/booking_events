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

const app = initializeApp(firebaseConfig);
const db = getDatabase()

db.collection('events').onSnapshot(snapshot => {
  // Handle the latest event
  const newestEvent = snapshot.docChanges()[0].doc.data()
  const id = snapshot.docChanges()[0].doc.id
  showLatestEvent(newestEvent, id);
  
  // shift the latest event element
  snapshot.docChanges().shift()
  
  snapshot.docChanges().forEach(event => {
      showEvents(event.doc.data(), event.doc.id)
  });
})

const addNewEvent = () => {
const event = {
  name: form.name.value,
  attendee: form.attendee.value,
  booked: 0,
  description: form.description.value,
  status: parseInt(form.status.value, 10)
}
  db.collection('events').add(event)
  .then(() => {
  // Reset the form values
  form.name.value = "",
  form.attendee.value = "",
  form.description.value = "",
  form.status.value = ""

  alert('Your event has been successfully saved')
  })
  .catch(err => console.log(err))
}

let bookedEvents = [];

const bookEvent = (booked, id) => {
const getBookedEvents = localStorage.getItem('booked-events');

  if (getBookedEvents) {
   bookedEvents = JSON.parse(localStorage.getItem('booked-events'));
    if(bookedEvents.includes(id)) {
      alert('Seems like you have already booked this event') 
    } 
    else {
      saveBooking(booked, id)
   }
  } 
  else {
      saveBooking(booked, id)
  }
};

const saveBooking = (booked, id) => {
  bookedEvents.push(id);
  localStorage.setItem('booked-events', JSON.stringify(bookedEvents));

  const data = { booked: booked +1 }
  db.collection('events').doc(id).update(data)
  .then(() => alert('Event successfully booked'))
  .catch(err => console.log(err))
}
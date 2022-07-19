import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class addBuses extends StatelessWidget {
  final String seats;
  final String number;

  addBuses(this.seats, this.number);

  Future add_the_buses() async{
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference users =
        FirebaseFirestore.instance.collection('buses');
    Future<void> addBuses() {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
            'seats': seats, 
            'bus_no': number,
          })
          .then((value) => print("Bus Added"))
          .catchError((error) => print("Failed to add Bus: $error"));
    }

    addBuses();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

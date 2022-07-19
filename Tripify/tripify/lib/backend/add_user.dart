import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddUser extends StatelessWidget {
  final String name;
  final String phonenum;
  final String username;
  final int selected_Value;
  final int rides;
  final int availed_discount;
  final String fee;

  AddUser(this.name, this.phonenum, this.username, this.selected_Value,this.rides,this.availed_discount,this.fee);

  Future add_the_user() async{
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference users =
        FirebaseFirestore.instance.collection('student');
    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
            'name': name, 
            'phone_num': phonenum, 
            'username': username,
            'selected_value': selected_Value,
            'rides':rides,
            'Discount_availed': availed_discount,
            'fee':fee
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    addUser();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetUserName extends StatelessWidget {
  final String email;
  // take the username in it and show's the output
  GetUserName(this.email);

// A function to fetch all the document id's in the database
  void get_data() {
    CollectionReference users =
        FirebaseFirestore.instance.collection('student');
    users.get().then((QuerySnapshot snapshot) => {
          snapshot.docs.forEach((DocumentSnapshot doc) {
            print(doc.id);
          })
        });
  }

  // now get the selected value from the backend
  Future? get_record_from_username()async {
    // A function to get a single Document from database using the username
    Object? data;
    CollectionReference users =
        FirebaseFirestore.instance.collection('student');
    // make a reference
    CollectionReference ref = FirebaseFirestore.instance.collection("student");
    // prepare the query
    final query = ref.where('username', isEqualTo: email);
    await query.get().then((QuerySnapshot snapshot) => {
          snapshot.docs.forEach((DocumentSnapshot doc) {
            data=jsonEncode((doc.data()));
            
          })
        });
      //  print('ets');
       // print(data);
        return data;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

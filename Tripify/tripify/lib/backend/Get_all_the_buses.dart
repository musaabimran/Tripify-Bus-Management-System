import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class All_buses_return extends StatelessWidget {
  final String email;
  // take the username in it and show's the output
  All_buses_return(this.email);

// A function to fetch all the document id's in the database
  void get_data() {
    CollectionReference users =
        FirebaseFirestore.instance.collection('buses');
    users.get().then((QuerySnapshot snapshot) => {
          snapshot.docs.forEach((DocumentSnapshot doc) {
            print(doc.id);
          })
        });
  }

  // now get the selected value from the backend
  Future? View_all_the_buses ()async {

  // FirebaseFirestore.instance.clearPersistence();
    List test=[];
    // A function to get a single Document from database using the username
    Object? data;
    CollectionReference users =
        FirebaseFirestore.instance.collection('buses');
    // make a reference
    CollectionReference ref = FirebaseFirestore.instance.collection("buses");
    // prepare the query
    await ref.get().then((QuerySnapshot snapshot) => {
          snapshot.docs.forEach((DocumentSnapshot doc) {
            data=jsonEncode((doc.data()));
            print(data);
      
            test.add(data);
            print("lol");
            
          })
        });
      //  print('ets');
       // print(data);
       print(test);
        return test;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

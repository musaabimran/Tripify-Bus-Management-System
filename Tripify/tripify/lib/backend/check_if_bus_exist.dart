import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class check_bus extends StatelessWidget {
  final String num;
  // take the username in it and show's the output
  check_bus(this.num);

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
  Future? Check_if_bus_exist ()async {

  // FirebaseFirestore.instance.clearPersistence();
    bool test=false;
    // A function to get a single Document from database using the username
    Object? data;
    CollectionReference users =
        FirebaseFirestore.instance.collection('buses');
    // make a reference
    CollectionReference ref = FirebaseFirestore.instance.collection("buses");
    // prepare the query
    final query = ref.where('bus_no', isEqualTo: num);
    await query.get().then((QuerySnapshot snapshot) => {
          snapshot.docs.forEach((DocumentSnapshot doc) {
            data=jsonEncode((doc.data()));
            print(data);
      
            test = true;
            
          })
        });
      //  print('ets');
       // print(data);
        return test;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class All_Driver_Return extends StatelessWidget {
  final String email;
  // take the username in it and show's the output
  All_Driver_Return(this.email);

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
  Future? View_All_Driver_info ()async {

  // FirebaseFirestore.instance.clearPersistence();
    List test=[];
    // A function to get a single Document from database using the username
    Object? data;
    CollectionReference users =
        FirebaseFirestore.instance.collection('student');
    // make a reference
    CollectionReference ref = FirebaseFirestore.instance.collection("student");
    // prepare the query
   final query = ref.where("selected_value", isEqualTo:2);
    await query.get().then((QuerySnapshot snapshot) => {
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

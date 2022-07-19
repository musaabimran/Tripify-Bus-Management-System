import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DelStudent extends StatelessWidget {
  final String email;
  // take the username in it and show's the output
  DelStudent(this.email);

  // now get the selected value from the backend
  Future? delete_student_by_id() async {
    // A function to get a single Document from database using the username
    String? data;
    // make a reference
    CollectionReference ref = FirebaseFirestore.instance.collection("student");
    // prepare the query
    final query = ref.where('username', isEqualTo: email);
    print("Received Email is: ");
    print(email);
    
    await query.get().then((QuerySnapshot snapshot) => {
          snapshot.docs.forEach((DocumentSnapshot doc) {
            print("huzaifi");
            data = doc.id;
            print(data);
            print(FirebaseAuth.instance.currentUser);
            
            //doc.reference.delete();
          })
        });

    print("deleted");
    return data;
  }


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

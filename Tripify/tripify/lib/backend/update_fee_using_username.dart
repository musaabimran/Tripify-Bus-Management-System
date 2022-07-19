import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class update_fee_backend extends StatelessWidget {
  final String email;
  // take the username in it and update the Name Field
  update_fee_backend(this.email); 
// now get the selected value from the backend
  Future? update_fee_from_username(String _new_fee)async {
    // A function to get a single Document from database using the username
    Object? data;
    CollectionReference users =
        FirebaseFirestore.instance.collection('student');
    // make a reference
    CollectionReference ref = FirebaseFirestore.instance.collection("student");
    // prepare the query
    final query = ref.where('username', isEqualTo: email);
    await query.get().then((QuerySnapshot snapshot) => {
          snapshot.docs.forEach((DocumentSnapshot docs) {
            data=jsonEncode((docs.data()));
            print(data);
           print("Backend server getting the data");
           print(docs.toString());
           FirebaseFirestore.instance.collection("student").doc(docs.id).update({
            "fee":_new_fee});
          })
        });
      //  print('ets');
        print(data);
        return data;
  }


  // for not showing error tbh
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
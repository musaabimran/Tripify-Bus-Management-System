import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DelBus extends StatelessWidget {
  final String bus_no;
  // take the username in it and show's the output
  DelBus(this.bus_no);

  // now get the selected value from the backend
  Future? delete_bus() async {
    // A function to get a single Document from database using the username
    String? data;
    // make a reference
    CollectionReference ref = FirebaseFirestore.instance.collection("buses");
    // prepare the query
    final query = ref.where('bus_no', isEqualTo: bus_no);
    print("Received Bus no is: ");
    print(bus_no);
    
    await query.get().then((QuerySnapshot snapshot) => {
          snapshot.docs.forEach((DocumentSnapshot doc) {
         
            data = doc.id;
            
            doc.reference.delete();
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

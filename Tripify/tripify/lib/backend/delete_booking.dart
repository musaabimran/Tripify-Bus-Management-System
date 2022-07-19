import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DelBooking extends StatelessWidget {
  final String email;
  // take the username in it and show's the output
  DelBooking(this.email);

  // now get the selected value from the backend
  Future? get_document_id_details() async {
    // A function to get a single Document from database using the username
    String? data;
    // make a reference
    CollectionReference ref = FirebaseFirestore.instance.collection("student");
    // prepare the query
    final query = ref.where('username', isEqualTo: email);
    await query.get().then((QuerySnapshot snapshot) => {
          snapshot.docs.forEach((DocumentSnapshot doc)  {
            data=doc.id;
          })
        });

    print("shahzada1");
    return data;
  }


  // now get the selected value from the backend
  Future<bool?> delete_booking() async {
    // A function to get a single Document from database using the username
   String info= await get_document_id_details();
   print("got this111: " );
   print(info);
    Object? data;

            CollectionReference ref2 = FirebaseFirestore.instance
                .collection("student")
                .doc(info)
                .collection("booking");
            final query2 = ref2.where('added', isEqualTo: "successful");

            await query2.get().then((QuerySnapshot snapshot) => {
                  snapshot.docs.forEach((DocumentSnapshot doc) async {
                    //deleting the data from the collection
                    doc.reference.delete();
                  })
                });

    print("shahzada2");
    return true;
  }





  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

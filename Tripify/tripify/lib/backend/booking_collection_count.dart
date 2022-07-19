import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CountBooking extends StatelessWidget {
  final String email;
  // take the username in it and show's the output
  CountBooking(this.email);

  // now get the selected value from the backend
  Future? get_booking_count() async {
    // A function to get a single Document from database using the username
    String? data;
    // make a reference
    CollectionReference ref = FirebaseFirestore.instance.collection("student");
    // prepare the query
    final query = ref.where('username', isEqualTo: email);
    await query.get().then((QuerySnapshot snapshot) => {
          snapshot.docs.forEach((DocumentSnapshot doc) {
            data = doc.id;
          })
        });

    print("shahzada1");
    return data;
  }

  // now get the selected value from the backend
  Future? get_count_of_booking_collection() async {
    // A function to get a single Document from database using the username
    String info = await get_booking_count();
    print("got this: ");
    print(info);
    Object? count;
    QuerySnapshot productCollection = await FirebaseFirestore.instance
        .collection("student")
        .doc(info)
        .collection("booking")
        .get();
    int productCount = productCollection.size;

    print(productCount);
    print("shahzada2");
    return productCount;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
//code to read the booking informaiton
/*
    User? user = await FirebaseAuth.instance.currentUser;
            // here We can Implement the logic of chaning The Name
     Object? _data = await GetBooking(Logged_In_Username.Currently_logged_in_user.toString()).get_booking_details();
         // parse the record
         print("in the main function printint the data");
        print(_data);
    Object _finalz =await jsonDecode(_data.toString());
    print(_finalz);
    // get all in the respected formatat
    final _fee = await booking_Test.fromJson(_finalz);
    print("testing the original function");
    print(_fee);
     print('check now');*/
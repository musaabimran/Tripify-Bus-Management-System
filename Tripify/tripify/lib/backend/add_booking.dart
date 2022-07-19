import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './delete_booking.dart';

class add_booking_info extends StatelessWidget {
  final String email;
  final String name;
  final String phone_num;
  final String starting_location;
  final String ending_location;
  final String discount;
  final String seat_num;
  final String boarding_num;
  // take the username in it and update the Name Field
  add_booking_info(this.email, this.name, this.phone_num,
      this.starting_location, this.ending_location, this.discount,this.seat_num,this.boarding_num);
// now get the selected value from the backend
  Future? add_booking_details() async {
    // A function to get a single Document from database using the username
    // Firsly we have to delete the previous record..
    bool? ans = await DelBooking(this.email).delete_booking();
    if (ans == true) {
      print("successfully deleted");
      Object? data;
      CollectionReference users =
          FirebaseFirestore.instance.collection('student');
      // make a reference
      CollectionReference ref =
          FirebaseFirestore.instance.collection("student");
      // prepare the query
      final query = ref.where('username', isEqualTo: email);
      await query.get().then((QuerySnapshot snapshot) => {
            snapshot.docs.forEach((DocumentSnapshot docs) {
              data = jsonEncode((docs.data()));
              print(data);
              print("Backend server getting the data");
              print(docs.toString());
              //making another collection inside of student information
              FirebaseFirestore.instance
                  .collection("student")
                  .doc(docs.id)
                  .collection("booking")
                  .add({
                    "added": "successful",
                    "name": name,
                    "phone_num": phone_num,
                    "src_address": starting_location,
                    "des_address": ending_location,
                    "discount_coide": discount,
                    "seat_num" : seat_num,
                    "boarding_num":boarding_num
                  })
                  .then((value) => print("Booking Added succesfuult"))
                  .catchError((error) => print("eRROR addding Bokking $error"));
            })
          });
      //  print('ets');
      print(data);
      return data;
    }
  }

  // for not showing error tbh
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

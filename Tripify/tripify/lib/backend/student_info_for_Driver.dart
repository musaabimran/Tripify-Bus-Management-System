import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Students_in_Bus extends StatelessWidget {
  final String email;
  // take the username in it and show's the output
  Students_in_Bus(this.email);

  // now get the selected value from the backend
  Future<List?> get_document_id_details() async {
    // A function to get a single Document from database using the username
    List? data=[];
    // make a reference
    CollectionReference ref = FirebaseFirestore.instance.collection("student");
    // prepare the query
    //final query = ref.where('username', isEqualTo: email);
    await ref.get().then((QuerySnapshot snapshot) => {
          snapshot.docs.forEach((DocumentSnapshot doc)  {
            data.add(doc.id);
            //Adding all the information to a docs
            print(data);
          })
        });

    print("shahzada2");
    return data;
  }


  // now get the selected value from the backend
  Future<List?> get_booking_details() async {
    // A function to get a single Document from database using the username
  List? original_info = [];
   List? info= await get_document_id_details();
   print("got this: " );
   print(info);
    Object? data;
    for(int i =0; i < info!.length; i++){
            CollectionReference ref2 = FirebaseFirestore.instance
                .collection("student")
                .doc(info[i])
                .collection("booking");
            final query2 = ref2.where('added', isEqualTo: "successful");

            await query2.get().then((QuerySnapshot snapshot) => {
                  snapshot.docs.forEach((DocumentSnapshot doc) async {
                    print("welcome welcome");
                    //print(doc);
                    data = jsonEncode((doc.data()));
                    original_info.add(data);
                    //print(data);
                  })
                });

    print("shahzada2");
      }
    return original_info;
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
     Object? _data = await Students_in_Bus(Logged_In_Username.Currently_logged_in_user.toString()).get_booking_details();
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
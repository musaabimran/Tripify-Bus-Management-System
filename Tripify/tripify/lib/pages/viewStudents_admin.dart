import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tripify/backend/Get_all_the_students.dart';
import 'button_style.dart';
import 'dart:convert';
import 'package:tripify/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
//Header files to get the data from the database
//import "../backend/Get_all_the_students.dart";

// the students
List _allStudents = [];

class ViewStudents extends StatefulWidget {
  final List colorUsed;
  final List fontsUsed;
  const ViewStudents(this.colorUsed, this.fontsUsed);

  @override
  State<ViewStudents> createState() => _ViewStudentsState();
}

class _ViewStudentsState extends State<ViewStudents> {
  initState() {
    fun();
  }

  fun() async {
    EasyLoading.show(status: "Fetching Students Info");
    List? _data = await All_Students_Return(
            Logged_In_Username.Currently_logged_in_user.toString())
        .View_All_Student_info();
        //converting to json
    List _finalz = await jsonDecode(_data.toString());
    // parse the record
    print("testing");
 
    setState(() {
       _allStudents = _finalz;
      print("Run first");
      
    print(_allStudents);
    });
      EasyLoading.dismiss();

    // get all in the respected formatat
    // final _fee = await fee_return.fromJson(_finalz);
    // convert to respective for conditions
    //  print(_fee);
    //  print("woeking");
    // _feeStatus = await _fee.toString();
    // print(_feeStatus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextCustomized(widget.colorUsed, "Students You have", 28),
              const SizedBox(
                height: 20,
              ),
              Table(
                border: TableBorder.all(
                  color: Color(widget.colorUsed[4]),
                  width: 2,
                ),

                // the responsive columns for the table
                columnWidths: const <int, TableColumnWidth>{
                  0: FlexColumnWidth(),
                  1: FlexColumnWidth(),
                  2: FlexColumnWidth(),
                },

                // allign the table
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,

                // the table data -- rows
                children: [
                  // table row
                  TableRow(
                    decoration: BoxDecoration(
                      color: Color(widget.colorUsed[2]),
                    ),
                    children: [
                      TextCustomized(widget.colorUsed, "Student Name", 20),
                      TextCustomized(widget.colorUsed, "Phone Number", 20),
                      TextCustomized(widget.colorUsed, "Total Rides", 20),
                    ],
                  ),

                  // the table data -- rows
                  for (var i = 0; i < _allStudents.length; i++)
                    TableRow(
                      children: [
                        TextCustomized(widget.colorUsed,
                            _allStudents[i]['name'], 18), //the boarding number
                        TextCustomized(
                            widget.colorUsed,
                            _allStudents[i]['phone_num'].toString(),
                            18), //the name
                        //the phone number
                        TextCustomized(widget.colorUsed,
                            _allStudents[i]['rides'].toString(), 18),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// for the text for the profile
class TextCustomized extends StatelessWidget {
  final List colorUsed;
  final String text;
  final double size;

  const TextCustomized(this.colorUsed, this.text, this.size, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 1, right: 1),
      child: Text(
        text,
        style: TextStyle(
          fontSize: size,
          color: Color(colorUsed[0]),
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

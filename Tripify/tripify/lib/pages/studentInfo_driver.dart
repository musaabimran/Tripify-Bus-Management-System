import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tripify/backend/student_info_for_Driver.dart';
import 'button_style.dart';
import 'dart:convert';
import 'package:tripify/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
//Header files to get the data from the database
import "../backend/read_user_data.dart";

class BusStudentsInfo extends StatefulWidget {
  final List colorUsed; // the colors used in the app
  final List fontsUsed; // the fonts used in the app

  BusStudentsInfo(this.colorUsed, this.fontsUsed);
  @override
  State<BusStudentsInfo> createState() => _BusStudentsInfo();
}

class _BusStudentsInfo extends State<BusStudentsInfo> {
// the list of the stidents in the bus of driver
  List _studentsInbus = [];
 
  bool loading = false;
  initState() {
    super.initState();
    fun();

  }

  fun() async {
    EasyLoading.show(status: "Fetching Information.Please Wait");
    print("wrong");
    List? _data = await Students_in_Bus(
            Logged_In_Username.Currently_logged_in_user.toString())
        .get_booking_details();
    // parse the record
    print("in the main function printint the data");
    print(_data);
    List?  _finalz = await jsonDecode(_data.toString());
    print(_finalz);
    // get all in the respected formatat
    //final _fee = await booking_Test.fromJson(_finalz);
    print("testing the original function");
    //print(_fee);
    print('check now');
    _studentsInbus = _finalz!;
    setState(() {
      _studentsInbus;
      print("ahemahem2");
    });
   
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {


    print("changed");
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextCustomized(
                (widget.colorUsed), "Today's Journey Companions", 28),
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
                TableRow(
                  decoration: BoxDecoration(
                    color: Color(widget.colorUsed[2]),
                  ),
                  children: [
                    TextCustomized(widget.colorUsed, "Boarding Number", 20),
                    TextCustomized(widget.colorUsed, "Name", 20),
                    TextCustomized(widget.colorUsed, "Phone Number", 20),
                  ],
                ),

                // the table data -- rows
                // printing the students in the bus
                for (var i = 0; i < _studentsInbus.length; i++)
                  TableRow(
                    children: [
                      TextCustomized(
                          widget.colorUsed,
                          _studentsInbus[i]['boarding_num'].toString(),
                          18), //the boarding number
                      TextCustomized(widget.colorUsed,
                          _studentsInbus[i]['name'].toString(), 18), //the name
                      TextCustomized(
                          widget.colorUsed,
                          _studentsInbus[i]['phone_num'].toString(),
                          18), //the phone number
                    ],
                  ),
              ],
            ),
          ],
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
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
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

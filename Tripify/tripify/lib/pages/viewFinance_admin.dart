import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tripify/backend/Get_all_the_students.dart';
import 'package:tripify/backend/Get_all_the_drivers.dart';
import 'button_style.dart';
import 'dart:convert';
import 'package:tripify/main.dart';
import 'package:firebase_auth/firebase_auth.dart';

// the Drivers
List _allDrivers = [
  {"name": "Usman", "phone number": "12345678901", "Salary Status": "Paid"},
  {"name": "Usman", "phone number": "12345678901", "Salary Status": "Paid"},
  {"name": "Usman", "phone number": "12345678901", "Salary Status": "Paid"},
  {"name": "Usman", "phone number": "12345678901", "Salary Status": "Paid"},
  {"name": "Usman", "phone number": "12345678901", "Salary Status": "Paid"},
  {"name": "mussab", "phone number": "12345678901", "Salary Status": "Paid"},
  {"name": "mussab", "phone number": "12345678901", "Salary Status": "Paid"},
  {"name": "musaab", "phone number": "12345678901", "Salary Status": "Paid"},
  {"name": "musaab", "phone number": "12345678901", "Salary Status": "Paid"},
  {"name": "musaab", "phone number": "12345678901", "Salary Status": "Paid"},
  {"name": "musaab", "phone number": "12345678901", "Salary Status": "Paid"},
  {"name": "musaab", "phone number": "12345678901", "Salary Status": "Paid"},
  {"name": "musaab", "phone number": "12345678901", "Salary Status": "Paid"},
  {"name": "musaab", "phone number": "12345678901", "Salary Status": "Paid"},
  {"name": "musaab", "phone number": "12345678901", "Salary Status": "Paid"},
  {"name": "musaab", "phone number": "12345678901", "Salary Status": "Paid"},
  {"name": "musaab", "phone number": "12345678901", "Salary Status": "Paid"},
];

// the Drivers
List _allStudents = [
  {"name": "Usman", "phone number": "12345678901", "Fee Status": "Paid"},
  {"name": "Usman", "phone number": "12345678901", "Fee Status": "Paid"},
  {"name": "Usman", "phone number": "12345678901", "Fee Status": "Paid"},
  {"name": "Usman", "phone number": "12345678901", "Fee Status": "Paid"},
  {"name": "Usman", "phone number": "12345678901", "Fee Status": "Paid"},
  {"name": "mussab", "phone number": "12345678901", "Fee Status": "Paid"},
  {"name": "mussab", "phone number": "12345678901", "Fee Status": "Paid"},
  {"name": "musaab", "phone number": "12345678901", "Fee Status": "Paid"},
  {"name": "musaab", "phone number": "12345678901", "Fee Status": "Paid"},
  {"name": "musaab", "phone number": "12345678901", "Fee Status": "Paid"},
  {"name": "musaab", "phone number": "12345678901", "Fee Status": "Paid"},
  {"name": "musaab", "phone number": "12345678901", "Fee Status": "Paid"},
  {"name": "musaab", "phone number": "12345678901", "Fee Status": "Paid"},
  {"name": "musaab", "phone number": "12345678901", "Fee Status": "Paid"},
  {"name": "musaab", "phone number": "12345678901", "Fee Status": "Paid"},
  {"name": "musaab", "phone number": "12345678901", "Fee Status": "Paid"},
  {"name": "musaab", "phone number": "12345678901", "Fee Status": "Paid"},
];

class ViewFinance extends StatefulWidget {
  final List colorUsed;
  final List fontsUsed;
  const ViewFinance(this.colorUsed, this.fontsUsed);




  @override
  State<ViewFinance> createState() => _ViewFinanceState();
}

class _ViewFinanceState extends State<ViewFinance> {


   initState() {
    fun();
  }

  fun() async {
    EasyLoading.show(status: "Fetching Information");
    List? _data1 = await All_Students_Return(
            Logged_In_Username.Currently_logged_in_user.toString())
        .View_All_Student_info();

        List? _data2 = await All_Driver_Return(
            Logged_In_Username.Currently_logged_in_user.toString())
        .View_All_Driver_info();
        //converting to json
    List _finalz1 = await jsonDecode(_data1.toString());
    List _finalz2 = await jsonDecode(_data2.toString());
    // parse the record
    print("testing");
 
    setState(() {
       _allStudents = _finalz1;
       _allDrivers = _finalz2;
      print("Run first");
      
    print(_allStudents);
    });
  EasyLoading.dismiss();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null,
      ),
      body: SingleChildScrollView(
        child:
            // the buttons
            Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextCustomized(widget.colorUsed, " Finance Details ", 28),
            ExpansionTile(
              title: const Text(
                "Driver Salary Status",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              children: [
                Container(
                  margin: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
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
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,

                        // the table data -- rows
                        children: [
                          // table row
                          TableRow(
                            decoration: BoxDecoration(
                              color: Color(widget.colorUsed[2]),
                            ),
                            children: [
                              TextCustomized(
                                  widget.colorUsed, "Student Name", 20),
                              TextCustomized(
                                  widget.colorUsed, "Phone Number", 20),
                              TextCustomized(
                                  widget.colorUsed, "Salary Status", 20),
                            ],
                          ),

                          // the table data -- rows
                          for (var i = 0; i < _allDrivers.length; i++)
                            TableRow(
                              children: [
                                TextCustomized(
                                    widget.colorUsed,
                                    _allDrivers[i]['name'].toString(),
                                    18), //the boarding number
                                TextCustomized(
                                    widget.colorUsed,
                                    _allDrivers[i]['phone_num'].toString(),
                                    18), //the name
                                //the phone number
                                TextCustomized(widget.colorUsed,
                                    _allDrivers[i]['fee'].toString(), 18),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: const Text(
                "Student Fee status",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              children: [
                Container(
                  margin: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
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
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,

                        // the table data -- rows
                        children: [
                          // table row
                          TableRow(
                            decoration: BoxDecoration(
                              color: Color(widget.colorUsed[2]),
                            ),
                            children: [
                              TextCustomized(
                                  widget.colorUsed, "Student Name", 20),
                              TextCustomized(
                                  widget.colorUsed, "Phone Number", 20),
                              TextCustomized(
                                  widget.colorUsed, "Fee status", 20),
                            ],
                          ),

                          // the table data -- rows
                          for (var i = 0; i < _allStudents.length; i++)
                            TableRow(
                              children: [
                                TextCustomized(
                                    widget.colorUsed,
                                    _allStudents[i]['name'].toString(),
                                    18), //the boarding number
                                TextCustomized(
                                    widget.colorUsed,
                                    _allStudents[i]['phone_num'].toString(),
                                    18), //the name
                                //the phone number
                                TextCustomized(widget.colorUsed,
                                    _allStudents[i]['fee'].toString(), 18),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
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

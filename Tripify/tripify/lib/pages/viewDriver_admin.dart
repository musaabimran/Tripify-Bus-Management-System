import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tripify/backend/Get_all_the_drivers.dart';
import 'button_style.dart';
import 'dart:convert';
import 'package:tripify/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
// the Drivers
List _allDrivers = [];

class ViewDrivers extends StatefulWidget {
  final List colorUsed;
  final List fontsUsed;
  const ViewDrivers(this.colorUsed, this.fontsUsed);

  @override
  State<ViewDrivers> createState() => _ViewDriversState();
}

class _ViewDriversState extends State<ViewDrivers> {

  initState() {
    fun();
  }

  fun() async {
    EasyLoading.show(status: "Fetching Drivers Info");
    List? _data = await All_Driver_Return(
            Logged_In_Username.Currently_logged_in_user.toString())
        .View_All_Driver_info();
        //converting to json

    
    List _finalz = await jsonDecode(_data.toString());
    // parse the record
    print("testing");
 
    setState(() {
       _allDrivers = _finalz;
      print("Run first");
      
    print(_allDrivers);
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
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextCustomized(widget.colorUsed, "Drivers You have", 28),
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
                      TextCustomized(widget.colorUsed, "Bus   Number", 20),
                    ],
                  ),

                  // the table data -- rows
                  for (var i = 0; i < _allDrivers.length; i++)
                    TableRow(
                      children: [
                        TextCustomized(widget.colorUsed, _allDrivers[i]['name'].toString(),
                            18), //the boarding number
                        TextCustomized(widget.colorUsed,
                            _allDrivers[i]['phone_num'].toString(), 18), //the name
                        //the phone number
                        TextCustomized(
                            widget.colorUsed, _allDrivers[i]['rides'].toString(), 18),
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

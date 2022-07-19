import 'package:flutter/material.dart';
import 'package:tripify/backend/remove_bus_no.dart';
import './button_style.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'button_style.dart';
import 'dart:convert';
import 'package:tripify/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../backend/add_buses.dart';
import '../backend/delete_buses.dart';
import '../backend/Get_all_the_buses.dart';

// the buses
List _allBuses = [
  {"name": "k-3899", "driver name": "naveed ahmed", "service status": "done"},
  {"name": "k-3899", "driver name": "naveed ahmed", "service status": "done"},
  {"name": "k-3899", "driver name": "naveed ahmed", "service status": "done"},
  {"name": "k-3899", "driver name": "naveed ahmed", "service status": "done"},
  {"name": "k-3899", "driver name": "naveed ahmed", "service status": "done"},
  {"name": "p-2000", "driver name": "naveed ahmed", "service status": "done"},
  {"name": "p-2000", "driver name": "naveed ahmed", "service status": "done"},
  {"name": "l-9001", "driver name": "naveed ahmed", "service status": "done"},
  {"name": "l-9001", "driver name": "naveed ahmed", "service status": "done"},
  {"name": "l-9001", "driver name": "naveed ahmed", "service status": "done"},
  {"name": "l-9001", "driver name": "naveed ahmed", "service status": "done"},
  {"name": "l-9001", "driver name": "naveed ahmed", "service status": "done"},
  {"name": "l-9001", "driver name": "naveed ahmed", "service status": "done"},
  {"name": "l-9001", "driver name": "naveed ahmed", "service status": "done"},
  {"name": "l-9001", "driver name": "naveed ahmed", "service status": "done"},
  {"name": "l-9001", "driver name": "naveed ahmed", "service status": "done"},
  {"name": "l-9001", "driver name": "naveed ahmed", "service status": "done"},
];

class ManageBus extends StatefulWidget {
  final List colorUsed;
  final List fontsUsed;
  ManageBus(this.colorUsed, this.fontsUsed);

  @override
  State<ManageBus> createState() => _ManageBusState();
}

class _ManageBusState extends State<ManageBus> {

    initState() {
    fun();
  }

  fun() async {
    EasyLoading.show(status: "Fetching Drivers Info");
    List? _data = await All_buses_return(
            Logged_In_Username.Currently_logged_in_user.toString())
        .View_all_the_buses();
        //converting to json

    
    List _finalz = await jsonDecode(_data.toString());
    // parse the record
    print("testing");
 
    setState(() {
       _allBuses = _finalz;
      print("Run first");
      
    print(_allBuses);
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
            TextCustomized(widget.colorUsed, " Buses Details ", 28),
            const SizedBox(
              height: 20,
            ),
            ExpansionTile(
              title: const Text(
                "Buses Status",
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
                                  widget.colorUsed, "Bus     Number", 20),
                              TextCustomized(
                                  widget.colorUsed, "Seats Number", 20),
                              TextCustomized(
                                  widget.colorUsed, "Service Status", 20),
                            ],
                          ),

                          // the table data -- rows
                          for (var i = 0; i < _allBuses.length; i++)
                            TableRow(
                              children: [
                                TextCustomized(
                                    widget.colorUsed,
                                    _allBuses[i]['bus_no'].toString(),
                                    18), //the boarding number
                                TextCustomized(widget.colorUsed,
                                    _allBuses[i]['seats'].toString(), 18), //the name
                                //the driver name
                                TextCustomized(widget.colorUsed,
                                    _allBuses[i]['service status'].toString(), 18),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextCustomized(widget.colorUsed, " Manage Buses ", 28),
            const SizedBox(
              height: 20,
            ),
            BusStatus(widget.colorUsed, widget.fontsUsed),
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

// for form validation
final _formkey = GlobalKey<FormState>();
// the other inputs
var _valueEntered = "";

// paid or unpaid for paid it is 0 and for unpaidit is 1
int _selectedValue = 0;

//to store the entered credentials
String _username = "";
String _busNumber = "";
String _pass = "";

void saveValue(String label) {
  // saving the data accordingly
  if (label == "username") {
    _username = _valueEntered;
    _username = _username.toLowerCase();
  } else if (label == "busNo") {
    _busNumber = _valueEntered;
  } else if (label == "pass") {
    _pass = _valueEntered;
  }
}

class BusStatus extends StatefulWidget {
  final List colorUsed;
  final List fontUsed;
  const BusStatus(this.colorUsed, this.fontUsed, {Key? key}) : super(key: key);

  @override
  State<BusStatus> createState() => _BusStatusState();
}

class _BusStatusState extends State<BusStatus> {
  


  // for upfating the fee status
  updateBusStatus() async {
    if (_formkey.currentState!.validate()) {
     
    await  EasyLoading.show(status: "Updating");


      final user = await FirebaseAuth.instance.currentUser;
      final cred =
          EmailAuthProvider.credential(email: user!.email!, password: _pass);
      
      user.reauthenticateWithCredential(cred).then((value) {

        
        // adding the Bus
        if (_selectedValue == 0) {
          addBuses(_username, _busNumber).add_the_buses();
        } else {
          DelBus(_busNumber).delete_bus();
        }
      }).catchError((err) {
        // Showing the Message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 3),
            backgroundColor: Color(widget.colorUsed[1]),
            content: Text(
              'Unable to Authenticate User.',
              style: TextStyle(fontSize: (widget.fontUsed[0])),
            ),
          ),
        );

        print(err);
      });
      EasyLoading.dismiss();
      setState(() {
        // database work --- ismail
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formkey,
        child: Column(children: [
          //  InputField("Current User Name", false, "username"),
          InputField("Enter Seats in Bus", false, "username"),

          InputField("Enter Number Of bus", false, "busNo"),

          //container for giving margins and paddings
          Container(
            width: 300,
            height: 60,
            padding: const EdgeInsets.all(10),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 1.0,
                  style: BorderStyle.solid,
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            margin: const EdgeInsets.all(10),
            child: DropdownButton(
                value: _selectedValue,
                items: const [
                  DropdownMenuItem(child: Text("Add Bus"), value: 0),
                  DropdownMenuItem(child: Text("Remove Bus"), value: 1),
                ],
                isExpanded: true, //to total width of container
                borderRadius: BorderRadius.circular(10),
                dropdownColor: Colors.white,

                //updatinf the value after changing
                onChanged: (int? value) {
                  setState(() {
                    // updating value also
                    _selectedValue = value!;
                  });
                }),
          ),

          InputField("Password", true, "pass"),
          Button(widget.colorUsed, widget.fontUsed, "Update Status",
              updateBusStatus),
        ]),
      ),
    );
  }
}

// input field widget
// the widget to hold the input fields
// the widget for making the customized text input fields
class InputField extends StatelessWidget {
  final String inputText;
  final String label; // so to identify which field
  final bool password; //the password thing that input feild is password
  InputField(this.inputText, this.password, this.label);

  // the list will use for the validation
  var specialChar = [
    '~',
    '`',
    '!',
    '@',
    '#',
    '\$',
    '%',
    '^',
    '&',
    '*',
    '(',
    ')',
    '+',
    '=',
    '{',
    '}',
    '[',
    ']',
    ':',
    ';',
    '"',
    '/',
    '\\',
    '|',
    '<',
    '>',
    ',',
    '?'
  ];

// overriding the build method to run
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(10),
      child: TextFormField(
        obscureText: password, //will be selected if password
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: inputText,
          constraints: const BoxConstraints(
            maxWidth: 300,
          ),
        ),

        // also validating the entered data
        validator: (value) {
          if (value!.isEmpty) {
            return "Can't be Empty";
          } else if (password) {
            // the things for password to be done security related
            // forcing to make the strong password
            if (value.length < 8) {
              // too short
              return "Too Short Password";
            }
            // now checking for the special character
            for (int i = 0; i < specialChar.length; i++) {
              // if any special character found
              if (value.contains(specialChar[i]) &&
                  value.contains(RegExp(r'[A-Z]')) &&
                  value.contains(RegExp(r'[0-9]'))) {
                // then checking for the capital alphabet

                // all found thus ok
                _valueEntered = value; //saving the value
                saveValue(label); // saving accordingly
                return null;
              }
            }
            // should use these
            return "Use Capital letter, Special Characters & Numbers";
          } else {
            // for stoping the injection attacks
            for (int i = 0; i < specialChar.length; i++) {
              // if any special character found
              if (value.contains(specialChar[i])) {
                return "Invalid Input :("; // special character found
              }
            }

            _valueEntered = value; //saving the value
            saveValue(label); // saving accordingly
            return null; //all well
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import './button_style.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tripify/backend/Get_all_the_drivers.dart';
import 'button_style.dart';
import 'dart:convert';
import 'package:tripify/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../backend/add_bus_no.dart';
import '../backend/remove_bus_no.dart';
import '../backend/check_if_bus_exist.dart';
// the Drivers
List _allDrivers = [
  {"name": "Usman", "phone number": "12345678901", "bus no": "k-3899"},
  {"name": "Usman", "phone number": "12345678901", "bus no": "k-3899"},
  {"name": "Usman", "phone number": "12345678901", "bus no": "k-3899"},
  {"name": "Usman", "phone number": "12345678901", "bus no": "k-3899"},
  {"name": "Usman", "phone number": "12345678901", "bus no": "k-3899"},
  {"name": "mussab", "phone number": "12345678901", "bus no": "k-3899"},
  {"name": "mussab", "phone number": "12345678901", "bus no": "k-3899"},
  {"name": "musaab", "phone number": "12345678901", "bus no": "k-3899"},
  {"name": "musaab", "phone number": "12345678901", "bus no": "k-3899"},
  {"name": "musaab", "phone number": "12345678901", "bus no": "k-3899"},
  {"name": "musaab", "phone number": "12345678901", "bus no": "k-3899"},
  {"name": "musaab", "phone number": "12345678901", "bus no": "k-3899"},
  {"name": "musaab", "phone number": "12345678901", "bus no": "k-3899"},
  {"name": "musaab", "phone number": "12345678901", "bus no": "k-3899"},
  {"name": "musaab", "phone number": "12345678901", "bus no": "k-3899"},
  {"name": "musaab", "phone number": "12345678901", "bus no": "k-3899"},
  {"name": "musaab", "phone number": "12345678901", "bus no": "k-3899"},
];

class ManageDriver extends StatefulWidget {
  final List colorUsed;
  final List fontsUsed;
  ManageDriver(this.colorUsed, this.fontsUsed);

  @override
  State<ManageDriver> createState() => _ManageDriverState();
}

class _ManageDriverState extends State<ManageDriver> {
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
        child:
            // the buttons
            Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextCustomized(widget.colorUsed, " Driver Details ", 28),
            const SizedBox(
              height: 20,
            ),
            ExpansionTile(
              title: const Text(
                "Drivers List",
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
                                  widget.colorUsed, "Bus   Number", 20),
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
                                    _allDrivers[i]['bus_no'].toString(), 18),
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
            TextCustomized(widget.colorUsed, " Assign Buses ", 28),
            const SizedBox(
              height: 20,
            ),
            DriverStatus(widget.colorUsed, widget.fontsUsed),
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

// the dropdown
int _selectedValue = 0;

//to store the entered credentials
String _username = "";
String _pass = "";
String _busNo = "";

void saveValue(String label) {
  // saving the data accordingly
  if (label == "username") {
    _username = _valueEntered;
    _username = _username.toLowerCase();
  } else if (label == "busNo") {
    _busNo = _valueEntered;
  } else if (label == "pass") {
    _pass = _valueEntered;
  }
}

class DriverStatus extends StatefulWidget {
  final List colorUsed;
  final List fontUsed;
  const DriverStatus(this.colorUsed, this.fontUsed, {Key? key})
      : super(key: key);

  @override
  State<DriverStatus> createState() => _DriverStatusState();
}

class _DriverStatusState extends State<DriverStatus> {
  // for upfating the fee status
  updateDriverStatus() async {
    if (_formkey.currentState!.validate()) {
      await EasyLoading.show(status: "Updating Bus No");
      final user = await FirebaseAuth.instance.currentUser;
      final cred =
          EmailAuthProvider.credential(email: user!.email!, password: _pass);

      user.reauthenticateWithCredential(cred).then((value)async {
        // Admin Authentificated Successfully.
        if (_selectedValue == 0) {
          // Check weaather the Bus No exists..
          bool? check =await check_bus(_busNo).Check_if_bus_exist();
          print("checking222");
          print(check);
          // add the bus noo
          if(check == true){
              add_bus_no(_username).add_bus_to_driver(_busNo);
          }else{
                    // Showing the Message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 3),
            backgroundColor: Color(widget.colorUsed[1]),
            content: Text(
              'Bus Do not Exist. Please Add Bus First',
              style: TextStyle(fontSize: (widget.fontUsed[0])),
            ),
          ),
        );
          }
          
        } else {
          // remove the bus noo
          remove_bus_no(_username).remove_bus_to_driver(_busNo);
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
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formkey,
        child: Column(children: [
          //  InputField("Current User Name", false, "username"),
          InputField("Enter Username of Driver", false, "username"),
          InputField("Enter Buss Number", false, "busNo"),
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
                  DropdownMenuItem(child: Text("Add Driver"), value: 0),
                  DropdownMenuItem(child: Text("Remove Driver"), value: 1),
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
          Button(
              widget.colorUsed, widget.fontUsed, "Update", updateDriverStatus),
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

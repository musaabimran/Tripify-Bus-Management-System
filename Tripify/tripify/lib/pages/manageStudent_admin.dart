
import './button_style.dart';
import 'dart:ffi';
import '../backend/delete_student.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tripify/backend/Get_all_the_students.dart';
import 'button_style.dart';
import 'dart:convert';
import 'package:tripify/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../backend/delete_booking.dart';
// the students
List _allStudents = [];

class ManageStudent extends StatefulWidget {
  final List colorUsed;
  final List fontsUsed;
  ManageStudent(this.colorUsed, this.fontsUsed);

  @override
  State<ManageStudent> createState() => _ManageStudentState();
}

class _ManageStudentState extends State<ManageStudent> {

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
        child:
            // the buttons
            Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextCustomized(widget.colorUsed, " Students Details ", 28),
            const SizedBox(
              height: 20,
            ),
            ExpansionTile(
              title: const Text(
                "Students List",
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
                                  widget.colorUsed, "Student UserName", 20),
                              TextCustomized(
                                  widget.colorUsed, "Phone Number", 20),
                              TextCustomized(
                                  widget.colorUsed, "Total Rides", 20),
                            ],
                          ),

                          // the table data -- rows
                          for (var i = 0; i < _allStudents.length; i++)
                            TableRow(
                              children: [
                                TextCustomized(
                                    widget.colorUsed,
                                    _allStudents[i]['username'].toString(),
                                    18), //the boarding number
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
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextCustomized(widget.colorUsed, " Remove Student Booking ", 28),
            const SizedBox(
              height: 20,
            ),
            StudentStatus(widget.colorUsed, widget.fontsUsed),
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

//to store the entered credentials
String _username = "";
String _pass = "";

void saveValue(String label) {
  // saving the data accordingly
  if (label == "username") {
    _username = _valueEntered;
    _username = _username.toLowerCase();
  } else if (label == "pass") {
    _pass = _valueEntered;
  }
}

class StudentStatus extends StatefulWidget {
  final List colorUsed;
  final List fontUsed;
  const StudentStatus(this.colorUsed, this.fontUsed, {Key? key})
      : super(key: key);

  @override
  State<StudentStatus> createState() => _StudentStatusState();
}

class _StudentStatusState extends State<StudentStatus> {
  // for upfating the fee status
  updateStudentStatus() async{
    // DelStudent(_username).delete_student_by_id();
    if (_formkey.currentState!.validate()) {

      EasyLoading.show(status: "Deleting Booking of Student");
         final user = await FirebaseAuth.instance.currentUser;
        final cred = EmailAuthProvider.credential(
            email: user!.email!, password: _pass);

        user.reauthenticateWithCredential(cred).then((value) {
          // Admin Authentificated Successfully.
          Future ans = DelBooking(_username).delete_booking();
          print(ans);
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
          InputField("Enter Username of student", false, "username"),

          InputField("Password", true, "pass"),
          Button(
              widget.colorUsed, widget.fontUsed, "Remove", updateStudentStatus),
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

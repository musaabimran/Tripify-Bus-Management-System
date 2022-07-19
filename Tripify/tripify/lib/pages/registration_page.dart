import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tripify/pages/booking_page.dart';
import '../backend/add_user.dart';
import 'dart:convert';
import "../backend/add_driver.dart";
//import '../backend/start_Work.dart';
// files
import "../backend/read_user_data.dart";
import 'dart:io';
import '../utilites/Error.dart';
import 'button_style.dart';
import './../utilites/routes.dart';
import './materialColor.dart';
import '../backend/selected_value_return.dart';

// the registration process
// making a stateFull widget because to take the credentaials and the save to DB
// there will be no such change in the page

class Registration extends StatefulWidget {
  final List colorsUsed;
  final List fontsUsed;

  Registration(this.colorsUsed, this.fontsUsed);

  @override
  State<Registration> createState() => _RegistrationState();
}

// the entered value
String _valueEntered = "";
// variable strings to be stoed in the database
//to store the entered credentials
String _name = "";
String _phoneNum = "";
String _username = "";
String _password = "";
int _rides = 0;
String _fee = "false";
int _avail_discount = 0;
int _selectedValue = 1; //the one for the drop down menu
//checking driver or student

void saveValue(String label) {
  // saving the data accordingly
  if (label == "username") {
    _username = _valueEntered;
    _username = _username.toLowerCase();
  } else if (label == "pass") {
    _password = _valueEntered;
  } else if (label == "name") {
    _name = _valueEntered;
  }
}

class _RegistrationState extends State<Registration> {
  bool _result = true; //will use in checking box
  final _formKey = GlobalKey<FormState>();

// A varible to check if the data is added to database sucessfully or not
  bool _is_user_added_to_database = true;
// the function stores the user information into the database
  Future add_to_database() async {

    if(_selectedValue == 0){
    // add the values to database
    try {
      await AddUser(_name, _phoneNum, _username, _selectedValue, _rides,
              _avail_discount, _fee)
          .add_the_user();
    } catch (e) {
      print("cannot add to database");
    }
    }else{
      final String _bus= "";
          try {
      await addDriver(_name, _phoneNum, _username, _selectedValue, _rides,
              _avail_discount, _fee,_bus)
          .add_the_driver();
    } catch (e) {
      print("cannot add to database");
    }
    }


  }

// A function to register the users
  Future register_user() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _username + "@example.com", password: _password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _is_user_added_to_database = false;
        // Will show a popup for the next//
        // Show the Error Message that the user not Found
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 3),
            backgroundColor: Color(widget.colorsUsed[1]),
            content: Text(
              'Password is too Weak',
              style: TextStyle(fontSize: (widget.fontsUsed[1])),
            ),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        _is_user_added_to_database = false;
        // Show the Error Message that the user not Found
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 3),
            backgroundColor: Color(widget.colorsUsed[1]),
            content: Text(
              'This Username is already Registered',
              style: TextStyle(fontSize: (widget.fontsUsed[1])),
            ),
          ),
        );
      }
    } catch (e) {
      _is_user_added_to_database = false;
      // Show the Error Message that the user not Found
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 3),
          backgroundColor: Color(widget.colorsUsed[1]),
          content: Text(
            'Something went Wrong Try Again Later',
            style: TextStyle(fontSize: (widget.fontsUsed[1])),
          ),
        ),
      );

      print("Something went Wrong");
    }
    return true;
  }

  // Varible to disable on Enable Form
  bool _isFormEnable = true;
  // A Function to change the state of the Button
  void Form_Toggle() {
    setState(() {
      _isFormEnable = !_isFormEnable;
    });
  }

// Once we are done go to the home page
  void gotoHomepage() async {
    // checking the form is filled validated or not
    if (_formKey.currentState!.validate()) {
      // setting it to true at first
      _is_user_added_to_database = true;
      // Add a loading screen
      EasyLoading.show(status: 'Registering');
      // remove the current Form
      Form_Toggle();

      await register_user();
      // Register the user only if it is added to the database
      if (_is_user_added_to_database) {
        // add the data to database
        await add_to_database();
        //HERE I CAN PUT THE REGISTER SUCCESSFUL MESSAGE
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 3),
            backgroundColor: Color(widget.colorsUsed[1]),
            content: Text(
              'Register Successfull. Please Log In',
              style: TextStyle(fontSize: (widget.fontsUsed[1])),
            ),
          ),
        );
        // navigating to the Login Page to Enter the Data
        Navigator.popAndPushNamed(context, MyRoutes.loginRoute);
      } else {
        // Show the Error Message that the user not Found
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 3),
            backgroundColor: Color(widget.colorsUsed[1]),
            content: Text(
              'Something went Wrong Try Again Later',
              style: TextStyle(fontSize: (widget.fontsUsed[1])),
            ),
          ),
        );
      }

      // Now remove the Above loading
      // we want to make that we reset the state of the text
      // sign out of the Firebase
      await FirebaseAuth.instance.signOut();
      EasyLoading.dismiss();
      // this will change the state of the Form
      Form_Toggle();
    } else {
      print("Validation of fronened went wrong1");
    }
  }

  // the form key
  @override
  Widget build(BuildContext context) {
    return Material(
      // making the form

      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(),
        // scrollview to avoid the overflow created by the keyboard when try to enter something
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                child: Text(
                  "Create Your Account",
                  style: TextStyle(
                    color: Color(widget.colorsUsed[0]),
                    fontSize: widget.fontsUsed[0],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Form(
                  key: _formKey, //using the global key maked above
                  //columns that will hold the text fields
                  child: Column(
                    children: [
                      // for taking the name
                      InputField("Name", false, "name"),
                      // InputField("Enter Your Phone number", false, "phoneNum"),

                      // phone number input
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(10),
                        child: TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                constraints: const BoxConstraints(
                                  maxWidth: 300,
                                ),
                                hintText: "Phone Number"),
                            keyboardType: TextInputType.number,
                            // also validating the entered data
                            validator: (String? value) {
                              if (value!.length == 11) {
                                //if 11 than valid as standard pakistani numbers
                                _phoneNum = value;
                                // if all correct then save
                                if (double.tryParse(_phoneNum) != null) {
                                  // then number thus returning null
                                  return null;
                                }

                                // else there will be the error
                                return "Only Numbers";
                              } else {
                                return "Invalid";
                              }
                            }),
                      ),

                      InputField("Username", false, "username"),
                      InputField("Password", true, "pass"),
                      //password thus true hide it

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
                              DropdownMenuItem(
                                  child: Text("Student"), value: 1),
                              DropdownMenuItem(child: Text("Driver"), value: 2),
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
                      // making the check box
                      // making thr row to hold the text also
                      Container(
                        alignment: Alignment.center,
                        width: 300,
                        // row ---- checkbox and text
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            // using theme to showing the uncheckbox red to highlight it
                            // so user if unchrck and button doesn't work s/he would check this
                            Theme(
                              data: ThemeData(
                                // when unselected made it red
                                unselectedWidgetColor: Colors.red,
                                // again refereshing our theme color the primary swatch
                                primarySwatch: createMaterialColor(
                                    Color(widget.colorsUsed[4])),
                              ),
                              child: Checkbox(
                                // the implementation of checked box
                                value: _result,
                                onChanged: (bool? valueNew) {
                                  // setting the state again on change so that to show checked
                                  setState(() {
                                    // updating the value of result
                                    _result =
                                        valueNew!; //updating the new value --- each time and setting the state
                                  });
                                },
                              ),
                            ), // using expanded to avoid the overflow of the long
                            const Expanded(
                              child: Text(
                                  "By checking you agree to the Privacy Policies of Tripify"),
                            ),
                          ],
                        ),

                        // if unchecked then higighliting the container
                        // decoration: ,
                      ),
                      // button maked passing the text and function that button will perform
                      if (_isFormEnable)
                        Button(
                          widget.colorsUsed,
                          widget.fontsUsed,
                          "Sign Up",
                          // if checked then will locked in otherwise button will not work
                          _result ? gotoHomepage : () {/*empty function*/},
                        ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

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

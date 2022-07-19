// ignore: unused_import

// ignore_for_file: deprecated_member_use, unnecessary_new

import 'dart:io';
import 'dart:convert';
import '../backend/selected_value_return.dart';
import "../backend/read_user_data.dart";
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tripify/utilites/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './button_style.dart';

// ignore: camel_case_types, use_key_in_widget_constructors
class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();

  final List colorsUsed;
  final List fontsUsed;

  LoginPage(this.colorsUsed, this.fontsUsed);
}

// the entered value
String _valueEntered = "";
// variable strings to be stoed in the database
//to store the entered credentials
String _username = "";
String _password = "";

void saveValue(String label) {
  // saving the data accordingly
  if (label == "username") {
    _username = _valueEntered;
    // converting to lower case for the better key management
    _username = _username.toLowerCase();
  } else if (label == "pass") {
    _password = _valueEntered;
  }
}

class _LoginPageState extends State<LoginPage> {
  // the global key for the form validation
  final _formKey = GlobalKey<FormState>();
  // Varible to disable on Enable Form
  bool _isFormEnable = true;
  // A Function to change the state of the Button
  void Form_Toggle() {
    setState(() {
      _isFormEnable = !_isFormEnable;
    });
  }

  // Database Implementation
  void login_user() async {
    // Add a loading screen
    EasyLoading.show(status: 'Validating');
    // remove the current Form
    Form_Toggle();
    // Validate here database
    try {
      // check if the user is avaliable in the DB
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _username + "@example.com", password: _password);
      // navigating to the home page if true no error in form
      // Show the Success
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 3),
          backgroundColor: Color(widget.colorsUsed[1]),
          content: Text(
            'User Logged In Successful',
            style: TextStyle(fontSize: (widget.fontsUsed[1])),
          ),
        ),
      );
      // Here we have to check what type of user is He.
      // get record from the database
      Object? data = await GetUserName(_username).get_record_from_username();
      // parse the record
      Object finalz = jsonDecode(data.toString());
      // print(finalz);
      // get it in the string formati
      final check = selected_value_return.fromJson(finalz);
      // convert to int for conditions
      int check2 = int.parse(check.toString());
      //String check2=check.toString();
      // checknig where we need to navigate the user

      // for the Admin
      if (check2 == 3) {
        Navigator.pushNamedAndRemoveUntil(
            context, MyRoutes.adminRoute, (Route<dynamic> route) => false);
        // for the driver
      } else if (check2 == 2) {
        print("Itnto driver");
        Navigator.pushNamedAndRemoveUntil(
            context, MyRoutes.driverRoute, (Route<dynamic> route) => false);
      } else {
        // for the student
        print("Itnto student");
        Navigator.pushNamedAndRemoveUntil(
            context, MyRoutes.homeRoute, (Route<dynamic> route) => false);
      }
    } on FirebaseAuthException catch (e) {
      // print("See the Error Fromt the Firebase" );
      //print(e);
      // see if we are unable to find th euser in the fireabse database
      // Show the Error Message that the user not Found
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 3),
          backgroundColor: Color(widget.colorsUsed[1]),
          content: Text(
            'Invalid Username or Password',
            style: TextStyle(fontSize: (widget.fontsUsed[1])),
          ),
        ),
      );
    }

    // we want to make that we reset the state of the text
    EasyLoading.dismiss();
    // this will change the state of the Form
    Form_Toggle();
  }

  // for loging in and validating the form
  void moveTohome() async {
    if (_formKey.currentState!.validate()) {
      // Now go and create the user account
      // create_account_backend();
      // Now go and login the user account
      login_user();
    } else {
      print("something went wrong with the validator");
    }
  }

  // for navigating to the home page
  void moveToregistration() {
    Navigator.pushNamed(context, MyRoutes.registerRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Image(
                image: AssetImage("./assets/images/logoLight.png"),
                width: 300.0,
                height: 250.0,
                alignment: Alignment.center,
              ),
              const SizedBox(
                height: 1.0,
              ),
              Text(
                "Login",
                style: TextStyle(
                  fontSize: widget.fontsUsed[0],
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                  color: Color(widget.colorsUsed[0]),
                ),
                textAlign: TextAlign.center,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    InputField("Username", false, "username"),
                    InputField("Password", true, "pass"),
                  ],
                ),
              ),
              if (_isFormEnable)
                Button(
                    widget.colorsUsed, widget.fontsUsed, "Login", moveTohome),
              FlatButton(
                onPressed: moveToregistration,
                // ignore: prefer_const_constructors
                child: Text(
                  " Register Here",
                  style: TextStyle(
                    color: Color(widget.colorsUsed[4]),
                    fontSize: widget.fontsUsed[1],
                  ),
                ),
              ),
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
  final bool password; //the password thing that input feild is password
  final String label;

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

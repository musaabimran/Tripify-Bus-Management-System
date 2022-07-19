import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import './button_style.dart';
import './../utilites/routes.dart';

class ChangePasswordDriver extends StatefulWidget {
  final List colorUsed;
  final List fontsUsed;

  ChangePasswordDriver(this.colorUsed, this.fontsUsed);

  @override
  State<ChangePasswordDriver> createState() => _ChangePasswordDriverState();
}

// the entered value
String _valueEntered = "";

//to store the entered credentials
String _username = "";
String _pass = "";
String _oldPass = "";
String _newPass = "";

void saveValue(String label) {
  // saving the data accordingly
  if (label == "username") {
    _username = _valueEntered;
    _username = _username.toLowerCase();
  } else if (label == "pass") {
    _pass = _valueEntered;
  } else if (label == "confirmPass") {
    _newPass = _valueEntered;
  } else if (label == "oldPass") {
    _oldPass = _valueEntered;
  }
}

// the statefull class
class _ChangePasswordDriverState extends State<ChangePasswordDriver> {
  @override
  void changePass() async {
    if (_formkey.currentState!.validate()) {
      await EasyLoading.show(status: "Changing Password");
      print(_pass);
      print(_newPass);
      print(_oldPass);
      //checking weather the fiRRelds are same or not
      if (_pass == _newPass) {
        final user = await FirebaseAuth.instance.currentUser;
        final cred = EmailAuthProvider.credential(
            email: user!.email!, password: _oldPass);

        user.reauthenticateWithCredential(cred).then((value) {
          user.updatePassword(_newPass).then((_) {
            //Success, do something
            // Showing the Message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(seconds: 3),
                backgroundColor: Color(widget.colorUsed[1]),
                content: Text(
                  'Password Changed Succesfully.',
                  style: TextStyle(fontSize: (widget.fontsUsed[1])),
                ),
              ),
            );

            MyRoutes.index = 4; //specifying the index initallay will be 0
            Navigator.popAndPushNamed(context, MyRoutes.driverRoute);
          }).catchError((error) {
            // Showing the Message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(seconds: 3),
                backgroundColor: Color(widget.colorUsed[1]),
                content: Text(
                  'Unable to Change Password.Try Again Later',
                  style: TextStyle(fontSize: (widget.fontsUsed[1])),
                ),
              ),
            );

            //Error, show something
          });
        }).catchError((err) {
          // Showing the Message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 3),
              backgroundColor: Color(widget.colorUsed[1]),
              content: Text(
                'Unable to Authenticate User.',
                style: TextStyle(fontSize: (widget.fontsUsed[1])),
              ),
            ),
          );

          print(err);
        });
      } else {
        // Showing the Message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 3),
            backgroundColor: Color(widget.colorUsed[1]),
            content: Text(
              'Error Password and Confirm Password do not Match.',
              style: TextStyle(fontSize: (widget.fontsUsed[1])),
            ),
          ),
        );
      }

      EasyLoading.dismiss();
    }
  }

  // for form validation
  final _formkey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(10.0),
      child: Form(
        key: _formkey,
        child: Column(children: [
          //      InputField("User Name", false, "username"),
          InputField("Old Password", true, "oldPass"),
          InputField("New Password", true, "pass"),
          InputField("Confirm Password", true, "confirmPass"),
          Button(widget.colorUsed, widget.fontsUsed, "Update", changePass),
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

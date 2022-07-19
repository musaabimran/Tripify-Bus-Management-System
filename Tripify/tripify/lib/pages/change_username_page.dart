import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tripify/backend/update_name_using_username.dart';
import 'package:tripify/utilites/routes.dart';
import './button_style.dart';
import 'package:tripify/main.dart';
import 'profile_page.dart';

class ChangeUsername extends StatefulWidget {
  final List colorUsed;
  final List fontsUsed;

  ChangeUsername(this.colorUsed, this.fontsUsed);

  @override
  State<ChangeUsername> createState() => _ChangeUsernameState();
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
  if (label == "newUsername") {
    _username = _valueEntered;
    _username = _username.toLowerCase();
  } else if (label == "pass") {
    _pass = _valueEntered;
  } else if (label == "confirmPass") {
    _newPass = _valueEntered;
  }
}

// the statefull class
class _ChangeUsernameState extends State<ChangeUsername> {
  @override
  void ChangeUsername() async {
    if (_formkey.currentState!.validate()) {
      EasyLoading.show(status: "Changing Username");

      // once input is validated
      print("Result Auth 1111");
      try {
        // get the information of the curent user
        User? user = await FirebaseAuth.instance.currentUser;
        // making sure that the user enters the correct password by reauthe
        UserCredential authResult = await user!.reauthenticateWithCredential(
          EmailAuthProvider.credential(
            // applying null check
            email: user.email!,
            password: _pass,
          ),
        );
        // here We can Implement the logic of chaning The Name
        Object? _data = await update_name_backend(
                Logged_In_Username.Currently_logged_in_user.toString())
            .update_name_using_username(_username);

        print("Result Auth");
        print(authResult);
        // Showing the Message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 3),
            backgroundColor: Color(widget.colorUsed[1]),
            content: Text(
              'Username Changed Succesfully.',
              style: TextStyle(fontSize: (widget.fontsUsed[1])),
            ),
          ),
        );

        MyRoutes.index = 4; //specifying the index initallay will be 0
        Navigator.popAndPushNamed(context, MyRoutes.homeRoute);
      } catch (e) {
        print("Errrrororo Auth");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 3),
            backgroundColor: Color(widget.colorUsed[1]),
            content: Text(
              'Password Incorrect or Something went Wrong.',
              style: TextStyle(fontSize: (widget.fontsUsed[1])),
            ),
          ),
        );
      }
      EasyLoading.dismiss();

      setState(() {
        // is_loading=true;
      });
    }
  }

  // for form validation
  final _formkey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formkey,
        child: Column(children: [
          //  InputField("Current User Name", false, "username"),
          InputField("New Display name", false, "newUsername"),
          InputField("Password", true, "pass"),
          Button(widget.colorUsed, widget.fontsUsed, "Update", ChangeUsername),
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

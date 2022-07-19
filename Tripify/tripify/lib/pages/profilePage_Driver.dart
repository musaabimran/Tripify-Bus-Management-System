import 'package:flutter/material.dart';
import 'package:tripify/backend/bus_no_return.dart';
import 'package:tripify/backend/discount_availed_return.dart';
import 'package:tripify/backend/name_return.dart';
import 'package:tripify/backend/phone_num_return.dart';
import 'package:tripify/main.dart';
import 'package:tripify/pages/changePassword_Driver.dart';
import 'package:tripify/pages/changeUsername_Driver.dart';
import 'dart:math';
import 'dart:convert';
import './change_password_page.dart';
import './change_username_page.dart';
import './button_style.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Header files to get the data from the database
import "../backend/read_user_data.dart";
import "../backend/rides_return.dart";

import "../utilites/routes.dart";

// will update from the database
String _name = "Dummy User";
String _phoneNumber = "Dummy Number";
String _username = "_dummy";
String _bus_no = "bus No";
bool _generateCodes = true;
int _ridesNo = 0;
int _availedDiscounts = 0;
//---------------
List discountCupons = [];
int _num = 1;
List _busInfo = ["sd-3899", "22", "Done"];

//the discount cuppons qunayity that are not availed
int _discount = ((_ridesNo / 20) - _availedDiscounts).toInt();

class MyProfileDriver extends StatefulWidget {
  final List colorUsed;
  final List fontsUsed;

  const MyProfileDriver(this.colorUsed, this.fontsUsed, {Key? key})
      : super(key: key);

  @override
  State<MyProfileDriver> createState() => MyProfileDriverState();
}

class MyProfileDriverState extends State<MyProfileDriver> {
  void log_out_user() {
    // signing user out of his account
    FirebaseAuth.instance.signOut();
    // Navigating to the login page
    Navigator.pushNamedAndRemoveUntil(
        context, MyRoutes.root, (Route<dynamic> route) => false);
    Navigator.pushNamed(context, MyRoutes.loginRoute);
  }

  discounts() async {
    EasyLoading.show(status: 'Getting Information');
    //-----------------------------------Backend Code-----------------------------//
    // getting the data from the database
    // get record from the database
    Object? _data = await GetUserName(
            Logged_In_Username.Currently_logged_in_user.toString())
        .get_record_from_username();
    // parse the record
    Object _finalz = jsonDecode(_data.toString());
    // get all in the respected formatat
    final _rides_from_database = rides_return.fromJson(_finalz);
    final _name_from_database = name_return.fromJson(_finalz);
    final _phone_num_from_database = phone_num_return.fromJson(_finalz);
     final _bus_no_from_database = bus_no_return.fromJson(_finalz);
    final _discount_availed__from_database =
        discount_availed_return.fromJson(_finalz);
    // convert to respective for conditions
    int _rides_from_database_ = int.parse(_rides_from_database.toString());
    int _discount_availed__from_database_ =
        int.parse(_discount_availed__from_database.toString());
    String _name_from_database_ = (_name_from_database.toString());
    String _phone_num_from_database_ = (_phone_num_from_database.toString());
    String _bus_no_from_database_=(_bus_no_from_database.toString());
    // Assigning the data to the respective variables to update the state
    _ridesNo = _rides_from_database_;
    _name = _name_from_database_;
    _phoneNumber = _phone_num_from_database_;
    _username = Logged_In_Username.Currently_logged_in_user.toString();
    _availedDiscounts = _discount_availed__from_database_;
    _busInfo[0]=_bus_no_from_database_;
    EasyLoading.dismiss();
    setState(() {
      // call the function that refereshes from the database
      state_updated = true;

      if (_generateCodes) {
        //now generating the discuont cupons
        for (int i = 0; i < _discount; i++) {
          //generating the discount cupons
          discountCupons.add(Random.secure().nextInt(999999999));
        }
      }

      // codes generated
      _generateCodes = false;
    });
  }

  bool state_updated = false;
// A function that decides the intial state of the application
  void initState() {
    discounts();
    state_updated = true;
  }

  @override
  Widget build(BuildContext context) {
    //for the discount cupons -- start from 1 whenever the page is reloaded
    _num = 1;
    // This function will fetch the original data from the database

    return SingleChildScrollView(
        child: ConstrainedBox(
      constraints: const BoxConstraints(),
      child: Column(
        children: [
          // the logo image --- only tripify logo
          Container(
            width: double.infinity,
            height: 100,
            color: Color(widget.colorUsed[4]),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: Image.asset("assets/images/tripifyOnly_Light.png"),
            ),
          ),

          // the avatar container
          Container(
            height: 120,
            width: 120,
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage("./assets/images/profile.jpg"),
                fit: BoxFit.cover,
              ),
              shape: BoxShape.circle,
              border: Border.all(
                color: Color(widget.colorUsed[0]),
                width: 3,
              ),
            ),
          ),

          // the text container
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            child: Column(
              children: [
                TextCustomized(widget.colorUsed, _name, 22), //name
                TextCustomized(
                    widget.colorUsed, _phoneNumber, 22), //phone number
                TextCustomized(widget.colorUsed, _username, 22), //username
              ],
            ),
          ),

          // the break
          Divider(
            color: Color(widget.colorUsed[4]),
            thickness: 10,
          ),

          // buss info conainer
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                // dividing
                const SizedBox(
                  height: 10,
                ),

                // the bus icon container
                Container(
                  decoration: BoxDecoration(
                    color: Color(widget.colorUsed[2]),
                    border: Border.all(
                      color: Color(widget.colorUsed[4]),
                      width: 3,
                    ),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Icon(
                    Icons.bus_alert,
                    color: Color(widget.colorUsed[0]),
                    size: 60,
                  ),
                ),
                // the break
                const SizedBox(
                  height: 20,
                ),

                TextCustomized(widget.colorUsed, "Your Bus Details", 25),

                const SizedBox(
                  height: 10,
                ),

                Container(
                  margin: const EdgeInsets.all(20.0),
                  child: Table(
                    border: TableBorder.all(
                      color: Color(widget.colorUsed[4]),
                      width: 2,
                    ),

                    // the responsive columns for the table
                    columnWidths: const <int, TableColumnWidth>{
                      0: FlexColumnWidth(),
                      1: FlexColumnWidth(),
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
                          TextCustomized(widget.colorUsed, "Bus Number", 20),
                          TextCustomized(widget.colorUsed, _busInfo[0], 20),
                        ],
                      ),

                      // the table data -- rows
                      TableRow(
                        children: [
                          TextCustomized(widget.colorUsed, "Seats", 20),
                          TextCustomized(widget.colorUsed, _busInfo[1], 20),
                        ],
                      ),

                      TableRow(
                        decoration: BoxDecoration(
                          color: Color(widget.colorUsed[2]),
                        ),
                        children: [
                          TextCustomized(widget.colorUsed, "Service", 20),
                          TextCustomized(widget.colorUsed, _busInfo[2], 20),
                        ],
                      ),
                    ],
                  ),
                ),

                TextCustomized(
                    widget.colorUsed, "Meet Admin for any quries", 18),

                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),

          // the break
          Divider(
            color: Color(widget.colorUsed[4]),
            thickness: 10,
          ),

          // the buttons
          ExpansionTile(
            title: const Text(
              "Change Display Name",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: [
              ChangeUsernameDriver(widget.colorUsed, widget.fontsUsed),
            ],
          ),
          ExpansionTile(
            title: const Text(
              "Change Password",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: [
              ChangePasswordDriver(widget.colorUsed, widget.fontsUsed),
            ],
          ),

          Container(
            width: double.infinity,
            color: Color(widget.colorUsed[4]),
            child: Button(
              widget.colorUsed,
              widget.fontsUsed,
              "Log Out",
              () {
                log_out_user();
              },
            ),
          ),
        ],
      ),
    ));
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
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: Color(colorUsed[0]),
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}

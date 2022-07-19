import 'package:flutter/material.dart';
import 'package:tripify/backend/discount_availed_return.dart';
import 'package:tripify/backend/name_return.dart';
import 'package:tripify/backend/phone_num_return.dart';
import 'package:tripify/main.dart';
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
import '../utilites/routes.dart';

// will update from the database
String _name = "Dummy User";
String _phoneNumber = "Dummy Number";
String _username = "_dummy";
bool _generateCodes = true;
int _ridesNo = 0;
int _availedDiscounts = 0;
//---------------
List discountCupons = [];
int _num = 1;

//the discount cuppons qunayity that are not availed
int _discount = ((_ridesNo / 20) - _availedDiscounts).toInt();

class MyProfile extends StatefulWidget {
  final List colorUsed;
  final List fontsUsed;

  const MyProfile(this.colorUsed, this.fontsUsed, {Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => MyProfileState();
}

class MyProfileState extends State<MyProfile> {
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
    final _discount_availed__from_database =
        discount_availed_return.fromJson(_finalz);
    // convert to respective for conditions
    int _rides_from_database_ = int.parse(_rides_from_database.toString());
    int _discount_availed__from_database_ =
        int.parse(_discount_availed__from_database.toString());
    String _name_from_database_ = (_name_from_database.toString());
    String _phone_num_from_database_ = (_phone_num_from_database.toString());
    // Assigning the data to the respective variables to update the state
    _ridesNo = _rides_from_database_;
    _name = _name_from_database_;
    _phoneNumber = _phone_num_from_database_;
    _username = Logged_In_Username.Currently_logged_in_user.toString();
    _availedDiscounts = _discount_availed__from_database_;
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
      constraints: BoxConstraints(),
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

          // the showing count of rides
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            alignment: Alignment.center,
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: CircularProgressIndicator(
                        value: _ridesNo == 0
                            ? 0
                            : _ridesNo > 20
                                ? ((_ridesNo -
                                        (20 *
                                            (_discount + _availedDiscounts))) /
                                    20)
                                : _ridesNo / 20,
                        backgroundColor: Color(widget.colorUsed[2]),
                        color: Color(widget.colorUsed[3]),
                        strokeWidth: 8,
                      ),
                    ),
                    Column(
                      children: [
                        TextCustomized(widget.colorUsed, "Rides", 22),
                        TextCustomized(
                            widget.colorUsed, _ridesNo.toString(), 22)
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          TextCustomized(widget.colorUsed,
              "For each 20 rides you get a Discount Coupon", 18),

          // dividing
          const SizedBox(
            height: 10,
          ),
          Divider(
            color: Color(widget.colorUsed[0]),
            thickness: 1,
          ),
          // the break
          const SizedBox(
            height: 10,
          ),

          // the details of the discount codes
          _generateCodes == true
              ? Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  child: TextCustomized(
                      widget.colorUsed, "Discount Coupons : $_discount", 22),
                )
              : DiscountDetails(widget.colorUsed, widget.fontsUsed),
          // button to generate the discount codes
          Button(widget.colorUsed, widget.fontsUsed, "Get Code", discounts),

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
              ChangeUsername(widget.colorUsed, widget.fontsUsed),
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
              ChangePassword(widget.colorUsed, widget.fontsUsed),
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

class TextDispaly extends StatelessWidget {
  const TextDispaly({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
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

// the discount details
class DiscountDetails extends StatelessWidget {
  final List colorUsed;
  final List fontsUsed;

  const DiscountDetails(this.colorUsed, this.fontsUsed, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, right: 10, bottom: 10, left: 10),
      child: Column(
        children: [
          TextCustomized(colorUsed, "Discount Details", 22),
          const SizedBox(
            height: 10,
          ),
          Table(
            border: TableBorder.all(
              color: Color(colorUsed[4]),
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
              TableRow(
                decoration: BoxDecoration(
                  color: Color(colorUsed[2]),
                ),
                children: [
                  TextCustomized(colorUsed, "Coupon No", 20),
                  TextCustomized(colorUsed, "Code", 20),
                  TextCustomized(colorUsed, "Status", 20),
                ],
              ),

              // the table data -- rows the coupons used
              for (int i = 0; i < _availedDiscounts; _num++, i++)
                TableRow(
                  children: [
                    (TextCustomized(colorUsed, "$_num ", 18)),
                    (TextCustomized(colorUsed, "-", 18)),
                    (TextCustomized(colorUsed, "Used", 18)),
                  ],
                ),

              for (int i = 0; i < _discount; _num++, i++)
                TableRow(
                  children: [
                    (TextCustomized(colorUsed, "$_num ", 18)),
                    (TextCustomized(
                        colorUsed, discountCupons[i].toString(), 18)),
                    (TextCustomized(colorUsed, "Valid", 18)),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}

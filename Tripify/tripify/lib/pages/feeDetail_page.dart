import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tripify/backend/fee_return.dart';
import 'button_style.dart';
import 'dart:convert';
import 'package:tripify/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
//Header files to get the data from the database
import "../backend/read_user_data.dart";

class FeeDetails extends StatefulWidget {
  final List colorsUsed; // the colors used in the app
  final List fontsUsed; // the fonts used in the app

  FeeDetails(this.colorsUsed, this.fontsUsed);
  @override
  State<FeeDetails> createState() => _FeeDetails();
}

class _FeeDetails extends State<FeeDetails> {
  // this will be reading the fee variable from the database
  String _feeStatus = "";

  initState() {
    myfun();
  }

  bool loading = false;
  void update_State() {
    print("well i am runing");
    print(_feeStatus);
    setState(() {
      _feeStatus = _feeStatus;
      if (_feeStatus == "true ") {
        print("_feeStatus");
      }

      // _feeStatus=_feeStatus;
    });
  }

  myfun() async {
    // Fetching Information
    EasyLoading.show(status: 'Getting Information');
    //-----------------------------------Backend Code-----------------------------//
    // getting the data from the database
    // get record from the database
    Object? _data = await GetUserName(
            Logged_In_Username.Currently_logged_in_user.toString())
        .get_record_from_username();
    // parse the record
    Object _finalz = await jsonDecode(_data.toString());
    // get all in the respected formatat
    final _fee = await fee_return.fromJson(_finalz);
    // convert to respective for conditions
    print(_fee);
    print("woeking");
    _feeStatus = await _fee.toString();
    print(_feeStatus);

    if (_feeStatus != "") {
      update_State();
      loading = true;
    }

    EasyLoading.dismiss();
    print(_feeStatus);
  }

  @override
  Widget build(BuildContext context) {
    print("I am loaded again");
    if (loading) {
      return SingleChildScrollView(
        child: Container(
            child: _feeStatus.compareTo("true ") == 0
                ? Center(
                    child: Column(
                      children: [
                        Container(
                            height: 280,
                            width: 280,
                            margin: const EdgeInsets.only(left: 30),
                            child: Image.asset('assets/images/paid.png')),
                        Container(
                          margin: const EdgeInsets.only(top: 40),
                          child: Column(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: Colors.green[900],
                                size: 100,
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                child: Text(
                                  'Fee Paid',
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Color(widget.colorsUsed[0]),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                'Enjoy the Rides :)',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(widget.colorsUsed[0]),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 60),
                                child: Text(
                                  'For any quries contact your Admin',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(widget.colorsUsed[0]),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 330,
                          width: 330,
                          child: Image.asset('assets/images/unpaid.png'),
                        ),
                        Column(
                          children: [
                            Icon(
                              Icons.cancel,
                              color: Colors.red[900],
                              size: 100,
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: Text(
                                'Fee Not Paid',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Color(widget.colorsUsed[0]),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                'Kindly Pay to Book Rides :(',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(widget.colorsUsed[0]),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 50),
                              child: Text(
                                'For any quries contact your Admin',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(widget.colorsUsed[0]),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
      );
    } else
      return Container();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tripify/backend/fee_return.dart';
import 'button_style.dart';
import 'dart:convert';
import 'package:tripify/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
//Header files to get the data from the database
import "../backend/read_user_data.dart";
import 'button_style.dart';

class SalaryDetails extends StatefulWidget {
  final List colorsUsed; // the colors used in the app
  final List fontsUsed; // the fonts used in the app

  SalaryDetails(this.colorsUsed, this.fontsUsed);
  @override
  State<SalaryDetails> createState() => _SalaryDetails();
}

class _SalaryDetails extends State<SalaryDetails> {
  // this will be reading the fee variable from the database
  String _salaryStatus = "";

  initState() {
    myfun();
  }

  bool loading = false;
  void update_State() {
    print("well i am runing");
    print(_salaryStatus);
    setState(() {
      _salaryStatus = _salaryStatus;
      print("whaaaa");
      if ((_salaryStatus == "true ") || (_salaryStatus == "true") || (_salaryStatus == "true  ")) {
        print("teststs");
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
    _salaryStatus = await _fee.toString();
    print(_salaryStatus);

    if (_salaryStatus != "") {
      update_State();
      loading = true;
    }

    EasyLoading.dismiss();
    print(_salaryStatus);
  }

  @override
  Widget build(BuildContext context) {
    _salaryStatus;
    if (loading) {
      return SingleChildScrollView(
        child: Container(
            child: (_salaryStatus.compareTo("true ") == 0) ||
                    (_salaryStatus.compareTo("true") == 0) ||
                     (_salaryStatus.compareTo("true  ") == 0)
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
                                  'Salary Available',
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Color(widget.colorsUsed[0]),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Text(
                                'Collect From the Admin',
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
                                'Salary Unavailable',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Color(widget.colorsUsed[0]),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 70),
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
    } else {
      return (Container());
    }
  }
}

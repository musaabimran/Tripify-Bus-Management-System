import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "../main.dart";
import 'dart:math';
import '../backend/add_booking.dart';
import '../backend/return_booking_added.dart';
import '../backend/read_booking.dart';
import './button_style.dart';
import './travel_details.dart';
import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../backend/booking_collection_count.dart';

var boardingPass = Random().nextInt(25);

//  ------- ismail -------
// fetch the adrress and boarding pass from the database
//  ------- ismail -------

bool _isBooked = false;
bool _setSeat = false;
var _disccountCode;
bool _feesStatus = true; // integrate with DB
int _rideCount = 0; //update from DB

class Booking extends StatefulWidget {
  final List colorsUsed;
  final List fontsUsed;

  Booking(this.colorsUsed, this.fontsUsed);

  @override
  State<Booking> createState() => _BookingState();
}

// the entered value
String _valueEntered = "";

// variable strings to be stoed in the database
//to store the entered credentials
String _souraddress = "";
String _desaddress = "Fast Islamabad";
String _phoneNum = "";
String _name = "";
String _seatnum = "";
int _selectedValue = 1; //the one for the drop down menu
//checking driver or student

void saveValue(String label) {
  // saving the data accordingly
  if (label == "location") {
    _souraddress = _valueEntered;
  } else if (label == "name") {
    _name = _valueEntered;
  } else if (label == "seat") {
    _seatnum = _valueEntered;
  }
}

class _BookingState extends State<Booking> {
  bool _result = true; //will use in checking box
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    is_ride_already_booked();
  }

  void is_ride_already_booked() async {
    EasyLoading.show(status: 'Fetching Information');
    // checking if the ride is already booked
    Object? val = await CountBooking(
            Logged_In_Username.Currently_logged_in_user.toString())
        .get_count_of_booking_collection();
    print("shahzada4");
    print(val.toString());
    val = val as int;
    if (val >= 1) {
      // of seat is full then redirect to the other page
      setState(() {
        _setSeat = true;
        _isBooked = true;
      });
    }

    EasyLoading.dismiss();
  }

  void bookNow() async {
    // the seat selected or not
    if (selectedSeat != 'S-1-1') {
      EasyLoading.show(status: 'Booking Ride');
      // Here we have to Book the Ride
      try {
        await add_booking_info(
                Logged_In_Username.Currently_logged_in_user.toString(),
                _name,
                _phoneNum,
                _souraddress,
                _desaddress,
                _disccountCode,
                selectedSeat.toString(),
                boardingPass.toString()
                )
            .add_booking_details();
      } catch (e) {
        print("Error in Firebase");
      }
      EasyLoading.dismiss();
      // look for discounts
      // if !discount then ride ++;
      _rideCount++; //save to DB

      setState(() {
        _isBooked = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 5),
        backgroundColor: Color(widget.colorsUsed[1]),
        content: Text(
          'Select the seat to continue',
          style: TextStyle(
            fontSize: (widget.fontsUsed[1]),
            fontWeight: FontWeight.bold,
          ),
        ),
      ));
    }
  }

  void goToseats() async {
    // testing

    if (_formKey.currentState!.validate()) {
      if (_feesStatus) {
        setState(() {
          _setSeat = true;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(seconds: 5),
          backgroundColor: Color(widget.colorsUsed[1]),
          content: Text(
            'Pay to book the ride ----- Contact Admin',
            style: TextStyle(
              fontSize: (widget.fontsUsed[1]),
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
      }
    }
  }

  void removeSeatvar() {
    _setSeat = false;
    setState(() {});
  }

  // the form key
  @override
  Widget build(BuildContext context) {
    return Container(
      // if both are not done
      child: !_isBooked && !_setSeat
          ? Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                  child: Text(
                    "Book your Trip",
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
                        InputField("Name", "name"),
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

                        InputField("Enter your location", "location"),

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
                                    child:
                                        Text("FAST University H11 Islamabad"),
                                    value: 1),
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

                        // cupon number
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
                                hintText: "Discount Code"),
                            keyboardType: TextInputType.number,
                            validator: (String? value) {
                              _disccountCode = value;
                              return null;
                            },
                          ),
                        ),

                        Button(
                          widget.colorsUsed,
                          widget.fontsUsed,
                          "Next",
                          goToseats,
                        )
                      ],
                    )),
              ],
            )
          // else if seat has been selected --- in seat selection -- but is not booked mean show the seats page
          : _setSeat && !_isBooked
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      Seats(widget.colorsUsed, widget.fontsUsed),
                      SizedBox(
                        width: double.infinity,
                        child: Button(
                          widget.colorsUsed,
                          widget.fontsUsed,
                          "Book Ride",
                          bookNow,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Button(
                          widget.colorsUsed,
                          widget.fontsUsed,
                          "Cancel Ride",
                          removeSeatvar,
                        ),
                      ),
                    ],
                  ),
                )
              // else is seat selected and booked then show the details
              : TravelDetails(widget.colorsUsed, widget.fontsUsed, boardingPass,
                  _souraddress),
    );
  }
}

String selectedSeat = "S" + selectedi.toString() + selectedj.toString();

class Seats extends StatelessWidget {
  final List colorsUsed; // the colors used in the app
  final List fontsUsed; // the fonts used in the app

  const Seats(this.colorsUsed, this.fontsUsed, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var _status = [
      [1, 1, 1, 0],
      [1, 1, 0, 1],
      [1, 1, 1, 1],
      [1, 1, 1, 1],
      [1, 1, 0, 0],
      [1, 1, 1, 1],
      [1, 1, 1, 1],
      [1, 1, 0, 1],
      [1, 0, 0, 1],
      [1, 1, 1, 1],
      [1, 1, 1, 1],
    ];

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: Text(
              'Select Your Seat',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(colorsUsed[0]),
              ),
            ),
          ),
          Container(
            height: 720,
            width: double.infinity,
            margin: const EdgeInsets.only(top: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.black,
                width: 3,
              ),
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                ),
                Column(
                  children: [
                    for (int i = 0; i <= 10; i++)
                      Container(
                          margin:
                              EdgeInsets.only(top: 1 == 4 ? size.width * 2 : 1),
                          child: Row(
                            children: <Widget>[
                              for (int j = 1; j <= 4; j++)
                                Expanded(
                                  // flex: j == 1 || j == 10 ? 2 : 1,
                                  child: (i == 0 && j == 2) ||
                                          (i == 2 && j == 3) ||
                                          (i == 1 && j == 3) ||
                                          (i == 1 && j == 4) ||
                                          (i == 3 && j == 3) ||
                                          (i == 3 && j == 2) ||
                                          (i == 3 && j == 1) ||
                                          (i == 3 && j == 0) ||
                                          //(i == 0 || j == 1) ||
                                          (i == 0 && j == 2) ||
                                          (i == 0 && j == 3) ||
                                          (i == 0 && j == 3)
                                      ? Container()
                                      : Container(
                                          height: size.width / 10,
                                          width: 100 / 10,
                                          margin: EdgeInsets.all(5.2),
                                          child: _status[i][j - 1] == 1
                                              ? Chairs(colorsUsed, fontsUsed,
                                                  true, selected, i, j)
                                              : Chairs(colorsUsed, fontsUsed,
                                                  false, true, i, j),
                                        ),
                                )
                            ],
                          ))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Chairs extends StatefulWidget {
  final List colorsUsed; // the colors used in the app
  final List fontsUsed; // the fonts used in the app
  final bool available; // the status of the chair
  final bool selected; // the status of the chair
  final int i;
  final int j;
  const Chairs(this.colorsUsed, this.fontsUsed, this.available, this.selected,
      this.i, this.j);

  @override
  State<Chairs> createState() => _ChairsState();
}

int colorSeat = 4;
double borderWidth = 0.0;
bool selected = false;
int selectedi = -1;
int selectedj = -1;

class _ChairsState extends State<Chairs> {
  select() {
    setState(() {
      selected = !selected;
      selectedi = selected ? widget.i : -1;
      selectedj = selected ? widget.j : -1;
      colorSeat = selected ? 1 : 4;
      borderWidth = selected ? 5.0 : 0.0;
      selectedSeat = "S" + selectedi.toString() + selectedj.toString();
    });
  }

  // for one seat only
  oneSeat() {
    print("only ");
    SnackBar(
      content: Text("1"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.available
        ? InkWell(
            child: Container(
              height: 12.0,
              width: 12.0,
              decoration: BoxDecoration(
                color: Color(widget.colorsUsed[colorSeat]),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: Color(widget.colorsUsed[0]),
                  width: borderWidth,
                ),
              ),
            ),
            onTap: () {
              ((selectedi == -1 && selectedj == -1) ||
                      (selectedi == widget.i && selectedj == widget.j))
                  ? select()
                  : oneSeat();
            },
          )
        : Container(
            height: 12.0,
            width: 12.0,
            decoration: BoxDecoration(
              color: Color(widget.colorsUsed[0]),
              borderRadius: BorderRadius.circular(6),
            ),
          );
  }
}

// the widget to hold the input fields
// the widget for making the customized text input fields
class InputField extends StatelessWidget {
  final String inputText;
  final String label; // so to identify which field
  InputField(this.inputText, this.label);

// overriding the build method to run
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(10),
      child: TextFormField(
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
          }

          // if all correct then save
          _valueEntered = value; //saving the value
          saveValue(label); // saving accordingly
          return null; //all well
        },
      ),
    );
  }
}

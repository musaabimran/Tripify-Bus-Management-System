import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:analog_clock/analog_clock.dart'; //for clock
// import 'package';
import '../utilites/routes.dart';
import './map_page.dart';

class HomePage extends StatelessWidget {
  final List colorUsed;
  final List fontsUsed;

  HomePage(this.colorUsed, this.fontsUsed);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            color: Color(colorUsed[0]),
            // the logo displaying
            // margin: const EdgeInsets.all(10),

            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                child: Image.asset(
                  "assets/images/tripifyOnly_Light.png",
                ),
              ),
            ),
          ),

          // some more containers to hold things
          Container(
            height: 510,
            decoration: BoxDecoration(
                border: Border.all(
              width: 2.0,
            )),
            child: SMap(),
          ),

          Container(
            // color: Color(colorUsed[0]),
            height: 255,
            color: Color(colorUsed[0]),
            child: Center(
              child: AnalogClock(
                width: 200,
                height: 200,
                isLive: true, //making live

                // styles
                hourHandColor: Colors.white,
                minuteHandColor: Colors.white,
                numberColor: Colors.white,

                textScaleFactor: 2,

                // the digital time
                // showDigitalClock: true,
                // digitalClockColor: Colors.black,
                showDigitalClock: false,

                showAllNumbers: true,

                // decoration borders
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2.0,
                    color: Colors.white,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Container(
            height: 255,
            decoration: BoxDecoration(
              border: Border.all(
                width: 2.0,
              ),
            ),
            child: Image.asset("assets/images/dua.png"),
          ),
        ],
      ),
    );
  }
}

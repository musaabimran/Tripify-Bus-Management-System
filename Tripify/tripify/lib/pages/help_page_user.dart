import 'package:flutter/material.dart';
import './dropDown.dart';

class HelpPageUser extends StatelessWidget {
  final List colorsUsed;
  final List fontsUsed;

  HelpPageUser(this.colorsUsed, this.fontsUsed);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Color(colorsUsed[0]),
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

        // for FAQs
        DropMedown(
            "How was your trip?",
            "Send your reviews at email feedback@tripify.com.",
            colorsUsed,
            fontsUsed),
        DropMedown(
            "Have you lost your item?",
            "Email us at support@trpify.com or contact us on this number 03227117752.",
            colorsUsed,
            fontsUsed),
        DropMedown(
            "Available locations?",
            "Currently tripfy is only availble fo FAST NUCES Islamabad.",
            colorsUsed,
            fontsUsed),
        DropMedown(
            "Why can't I see travel details?",
            "Check your ride booking and Internet connection.",
            colorsUsed,
            fontsUsed),

        DropMedown(
            "Why can't book ride?",
            "You should check your fee status or your Internet connection.",
            colorsUsed,
            fontsUsed),

        DropMedown(
            "What type of information we collect?",
            " 1. Geolocation \n 2. Contact Information \n 3. Address ",
            colorsUsed,
            fontsUsed),

        DropMedown(
            "Contact Us",
            " Email : support@tripify.com \n Address : Tripify, FAST NUCES H11/4 \n Phone : +91-1234567890 \n Website : www.tripify.com.",
            colorsUsed,
            fontsUsed),
        // the container to hold conact information

        Container(
          height: 50,
          // decoration: BoxDecoration(
          //   color: Color(colorsUsed[4]),
          //   border: Border.all(
          //     color: Color(colorsUsed[3]),
          //     width: 1,
          //   ),
          color: Color(colorsUsed[4]),

          child: Center(
            child: Text(
              "© Tripify, Powered by IMU solutions",
              style: TextStyle(
                fontSize: 18, //giving font size
                fontWeight: FontWeight.bold,
                color: Color(colorsUsed[3]),
              ),
            ),
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import './dropDown.dart';

class HelpPageAdmin extends StatelessWidget {
  final List colorsUsed;
  final List fontsUsed;

  HelpPageAdmin(this.colorsUsed, this.fontsUsed);

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

        const SizedBox(
          height: 70,
        ),

        // for FAQs
        DropMedown(
            "Available locations?",
            "Currently tripify is only availble for FAST NUCES Islamabad.",
            colorsUsed,
            fontsUsed),

        DropMedown("How to contact Development team?",
            "Contact Admin by email, support@IMU.com", colorsUsed, fontsUsed),

        DropMedown(
            "What type of information the app collect?",
            " 1. Geolocation \n 2. Contact Information \n 3. Address ",
            colorsUsed,
            fontsUsed),

        DropMedown(
            "Contact Us",
            "Email : support@IMU.com \nAddress : IMU, Software House G11/2 \nPhone : +91-1234560890 \nWebsite : www.IMU.com.",
            colorsUsed,
            fontsUsed),
        // the container to hold conact information

        const SizedBox(
          height: 70,
        ),

        Container(
          height: 50,
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

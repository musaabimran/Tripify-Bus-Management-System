import 'package:flutter/material.dart';

// for travel
class TravelDetails extends StatelessWidget {
  final List colorsUsed;
  final List fontsUsed;
  final int temp;
  final String srcAddrs;

  TravelDetails(this.colorsUsed, this.fontsUsed, this.temp, this.srcAddrs);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(2),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),

            Text(
              "Travel Details",
              style: TextStyle(
                fontSize: 28.0, //giving font size
                fontWeight: FontWeight.bold,
                color: Color(colorsUsed[4]),
              ),
            ),

            const SizedBox(
              height: 50,
            ),

            // ignore: prefer_const_constructors
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(colorsUsed[2]),
                border: Border.all(
                  color: Color(colorsUsed[0]),
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Image(
                          height: 120,
                          width: 100,
                          image:
                              AssetImage('assets/images/tripifyOnly_Dark.png')),
                      CustomizedText(colorsUsed, fontsUsed,
                          "\n   Boarding Ticket        "),
                      const Image(
                        height: 50,
                        width: 70,
                        image: AssetImage('assets/images/busOnly.png'),
                      ),
                    ],
                  ),
                  CustomizedText(
                    colorsUsed,
                    fontsUsed,
                    "\n   Boarding Number: $temp\n \n  ",
                  ),
                  CustomizedText(
                    colorsUsed,
                    fontsUsed,
                    "  Driver Info: \n  Name : Nadeem Salman \n  Phone : +91-1234567890 \n  Bus Number : APK 347",
                  ),
                  CustomizedText(
                    colorsUsed,
                    fontsUsed,
                    "\n\nFROM : $srcAddrs stop  \nTO : FAST, Islamabad  \n   \n  ",
                  )
                ],
              ),
            ),

            // the returning ticket
            const SizedBox(
              height: 50,
            ),
            // ignore: prefer_const_constructors
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(colorsUsed[2]),
                border: Border.all(
                  color: Color(colorsUsed[0]),
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Image(
                          height: 120,
                          width: 100,
                          image:
                              AssetImage('assets/images/tripifyOnly_Dark.png')),
                      CustomizedText(colorsUsed, fontsUsed,
                          "\n    Returning Ticket        "),
                      const Image(
                        height: 50,
                        width: 70,
                        image: AssetImage('assets/images/busOnly.png'),
                      ),
                    ],
                  ),
                  CustomizedText(
                    colorsUsed,
                    fontsUsed,
                    "\n   Boarding Number: $temp\n \n  ",
                  ),
                  CustomizedText(
                    colorsUsed,
                    fontsUsed,
                    "  Driver Info: \n  Name : Nadeem Salman \n  Phone : +91-1234567890 \n  Bus Number : APK 347",
                  ),
                  CustomizedText(colorsUsed, fontsUsed,
                      "\n\nFROM : FAST, Islamabad  \nTO : $srcAddrs stop  \n   \n  "),
                ],
              ),
            ),

            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomizedText extends StatelessWidget {
  final String text;
  final List colorsUsed;
  final List fontsUsed;

  const CustomizedText(this.colorsUsed, this.fontsUsed, this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20.0, //giving font size
        fontWeight: FontWeight.bold,
        color: Color(colorsUsed[4]),
      ),
    );
  }
}
